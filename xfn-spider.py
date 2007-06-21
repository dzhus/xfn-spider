#!/usr/bin/env python
import sys, urllib
import re
import libxml2, libxslt

# to avoid infinite loops
processed_urls = []

if len(sys.argv) <= 1:
    print "URL not specified!"
    sys.exit(1)

if len(sys.argv) <= 2:
    max_depth = 1
else:
    max_depth = int(sys.argv[2])

slash_end = re.compile(r'.*/$')

# Load all necessary stylsheets
mf_extract = libxslt.parseStylesheetFile("mf-extract.xsl")
mf_extract_bot = libxslt.parseStylesheetFile("mf-extract-bottom.xsl")
get_urls = libxslt.parseStylesheetFile("get-urls.xsl")
makedot = libxslt.parseStylesheetFile("makedot.xsl")
postprocess = libxslt.parseStylesheetFile("postprocess.xsl")

result_xml = libxml2.newDoc("1.0")
network = result_xml.addChild(libxml2.newNode('network'))

def dprint(msg):
    sys.stderr.write(msg + '\n')

def processURL(url, depth=0):
    global processed_urls, network

    if not slash_end.match(url):
        url = url + '/'        
    
    if url in processed_urls:
        return
    
    try:
        src = libxml2.readFile(url, None, libxml2.XML_PARSE_RECOVER + libxml2.XML_PARSE_NOERROR)
    except:
        if depth == 0:
            sys.exit(2)
        else:
            return

    if (depth == (max_depth + 1)):
        site = mf_extract_bot.applyStylesheet(src, {'site-url' : '"' + url + '"'})
    else:
        site = mf_extract.applyStylesheet(src, {'site-url' : '"' + url + '"'})
    network.addChild(site.getRootElement())

    processed_urls.append(url)

    if depth <= max_depth:
        # Next portion of URLs to parse
        nexturls_list = get_urls.applyStylesheet(site, None)
        for next in nexturls_list.get_content().splitlines():
            processURL(next, depth + 1)        
    
processURL(sys.argv[1])

result_xml = postprocess.applyStylesheet(result_xml, None)

print result_xml
