#!/bin/bash
#
# This is a quick-and-dirty converter of Sage TSV output to mzIdentML, with a separate Peptide id entry for each PSM, not each unique peptide.
# This may break some third-party software, and should be fixed in future versions. The software version is assumed to be the latest version
# of Sage (currently 0.14.5). There are currently (February 2024) no CV terms for Sage. Sage outputs "hyperscore". Assume that this is X!Tandem
# hyperscore for now.
#

# Check for input file
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 results.sage.tsv (or name of Sage results TSV file, if changed)"
    exit 1
fi

# get the current date and time (of the conversion to mzIdentML)
creationDate=`date -I'ns'|tr ',' '.'| awk 'sub("00\+.+","Z")'`

echo "creationDate" $creationDate

# Check Sage version (assumes Sage is in the current directory)
if [ -f ./sage.exe ]; then
	version=`./sage.exe --version | cut -f2 -d ' '`
	else
	version="UNKNOWN"
fi

echo "Sage version" $version

inputfile=$1
outputfile="${inputfile%.tsv}.mzid"

# Start and sequence collection of the mzIdentML file
awk -v version=$version -v creationDate=$creationDate '
	BEGIN {
		print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		printf("<MzIdentML xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" id=\"\" xsi:schemaLocation=\"http://psidev.info/psi/pi/mzIdentML/1.1 http://www.psidev.info/files/mzIdentML1.2.0.xsd\" creationDate=\"%s\" version=\"1.2.0\" xmlns=\"http://psidev.info/psi/pi/mzIdentML/1.2\">", creationDate);
		print("  <cvList>");
		print("    <cv fullName=\"Proteomics Standards Initiative Mass Spectrometry Vocabularies\" version=\"4.1.99\" uri=\"https://raw.githubusercontent.com/HUPO-PSI/psi-ms-CV/master/psi-ms.obo\" id=\"PSI-MS\" />");
		print("    <cv fullName=\"UNIMOD\" uri=\"https://raw.githubusercontent.com/HUPO-PSI/psi-ms-CV/master/psi-ms.obo\" id=\"UNIMOD\" />");
		print("    <cv fullName=\"UNIT-ONTOLOGY\" uri=\"http://obo.cvs.sourceforge.net/viewvc/obo/obo/ontology/phenotype/unit.obo\" id=\"UO\" />");
		print("  </cvList>");
		print("  <AnalysisSoftwareList>");
		printf("    <AnalysisSoftware id=\"Sage\" version=\"%s\" uri=\"https://github.com/lazear/sage\">\n", version);
		print("      <SoftwareName>");
		print("        <cvParam name=\"X!Tandem\" cvRef=\"PSI-MS\" accession=\"MS:1001456\" />"); # Pretend Sage hyperscores are X!Tandem hyperscores
		print("      </SoftwareName>");
		print("    </AnalysisSoftware>");
		print("  </AnalysisSoftwareList>");
		print("  <SequenceCollection>");
	}
	(NR>1) {
		printf("  <Peptide id=\"%s_%09d\">\n",$2,NR-1);
		printf("    <PeptideSequence>%s</PeptideSequence>\n",$2);
		printf("  </Peptide>\n");
		printf("  <PeptideEvidence id=\"%s_%09d_%s\" dBSequence_ref=\"DBSeq_%s\" peptide_ref=\"%s_%09d\" />\n", $2, NR-1, $3, $3, $2, NR-1);
		printf("  <DBSequence id=\"DBSeq_%s\" searchDatabase_ref=\"SearchDB_1\" accession=\"%s\">\n", $3, $3);
		printf("  <Seq>UNKNOWN</Seq>\n");
		printf("  <cvParam name=\"protein description\" value=\"\" cvRef=\"PSI-MS\" accession=\"MS:1001088\" />\n");
		print("</DBSequence>");
	}
	END {
	print("  </SequenceCollection>");

	}
' $inputfile > $outputfile

# Analysis data and end of the mzIdentML file
awk '
	BEGIN {
		print("  <DataCollection>");
		print("    <AnalysisData>");
		print("      <SpectrumIdentificationList id=\"SIL_1\">");
	}
	(NR>1) {
		sub("scan=", "", $8)
		printf("        <SpectrumIdentificationResult id=\"SIR_%i\" spectrumID=\"index=%i\" spectraData_ref=\"SD_%i\" name=\"%s\">\n", NR-2, NR-2, NR-1, $8);
		printf("          <SpectrumIdentificationItem id=\"SII_%i_%i\" chargeState=\"%i\" experimentalMassToCharge=\"%f\" calculatedMassToCharge=\"%f\" peptide_ref=\"%s_%09d\" rank=\"%i\">\n", NR-2, 1, $13, $11, $12, $2, NR-1, $9);
		printf("            <PeptideEvidenceRef peptideEvidence_ref=\"%s_%09d_%s\" />\n", $2, NR-1, $3);
		printf("            <cvParam name=\"X!Tandem:hyperscore\" value=\"%f\" cvRef=\"PSI-MS\" accession=\"MS:1001331\" />\n", $20); # Pretend to be X!Tandem hyperscore
		
		
		
		print("          </SpectrumIdentificationItem>");
		
		
		print("        </SpectrumIdentificationResult>");
	}
	END {
		print("      </SpectrumIdentificationList>");
		print("    </AnalysisData>");
		print("  </DataCollection>");
		print("</MzIdentML>");
	}
' $inputfile >> $outputfile

echo "Conversion completed: $outputfile"
