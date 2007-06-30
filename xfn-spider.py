#!/usr/bin/env python
import sys, urllib
import re
import tidy
import libxml2, libxslt

# @todo Module version checks

# to avoid infinite loops
processed_urls = []

# @todo -v option handling

if len(sys.argv) <= 1:
    print "URL not specified!"
    sys.exit(1)

if len(sys.argv) <= 2:
    max_depth = 1
else:
    max_depth = int(sys.argv[2])

slash_end = re.compile(r'/$')

# Load all necessary stylsheets
mf_extract = libxslt.parseStylesheetFile("mf-extract.xsl")
mf_extract_btm = libxslt.parseStylesheetFile("mf-extract-bottom.xsl")
get_urls = libxslt.parseStylesheetFile("get-urls.xsl")
postprocess = libxslt.parseStylesheetFile("postprocess.xsl")

result_xml = libxml2.newDoc("1.0")
network = result_xml.addChild(libxml2.newNode('network'))

def dprint(msg):
    sys.stderr.write(msg + '\n')

def processUrl(url, depth=0):
    global processed_urls, network

    if slash_end.match(url):
        url = slash_end.replace('', url)
    
    if url in processed_urls:
        return

    dprint('[%d] Processing %s' % (depth, url))
    
    try:
        sock = urllib.urlopen(url)
    except:
        if depth == 0:
            sys.exit(2)
        else:
            return
    
    options = dict(force_output=1, output_xhtml=1, add_xml_decl=1, char_encoding='utf8')
    page = tidy.parseString(sock.read(), **options)
    sock.close()
    # @todo Tidy tidiyng success check
    if len(str(page)):
        src = libxml2.readDoc(str(page), url, None, libxml2.XML_PARSE_RECOVER + libxml2.XML_PARSE_NOERROR)
    else:
        dprint('\tFailed on %s' % url)
        return

    if (depth == (max_depth + 1)):
        site = mf_extract_btm.applyStylesheet(src, {'site-url' : '"' + url + '"'})
    else:
        site = mf_extract.applyStylesheet(src, {'site-url' : '"' + url + '"'})
    network.addChild(site.getRootElement())

    processed_urls.append(url)

    if depth <= max_depth:
        nexturls_list = get_urls.applyStylesheet(site, None)
        for next in nexturls_list.get_content().splitlines():
            processUrl(next, depth + 1)        
    
processUrl(sys.argv[1])

result_xml = postprocess.applyStylesheet(result_xml, None)

print result_xml
