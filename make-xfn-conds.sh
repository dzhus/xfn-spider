for rel in contact friend acquaintance met co-worker colleague co-resident neighbor child parent sibling spouse kin muse crush date sweetheart me
do
    echo "<xsl:when test=\"contains(@rel, '$rel')\">"
    echo "<xsl:call-template name=\"xfn-link\" />"
    echo "</xsl:when>"
done