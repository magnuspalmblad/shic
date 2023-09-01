xmllint --xpath "//*[local-name()='uri']/text()" annotationsByArticleIds.xml | grep -oP "CHEBI.+" | sed 's/_/:/'
