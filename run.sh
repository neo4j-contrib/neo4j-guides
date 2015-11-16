echo "Usage ./run.sh OR ./run.sh path/to/a_guide.adoc [guide.html] [+1 (header-offset)]"
BASE_URL=http://guides.neo4j.com/intro
mkdir -p html
OFFSET=${3-+1}

function render {
   ADOC=${1-../exercise/lab_01.adoc}
   HTML=${ADOC%%.*}.html
   HTML=${HTML##*/}
   HTML=${2-$HTML}
   echo rendering $ADOC to html/$HTML   
   asciidoctor $ADOC -T templates -a guides=$BASE_URL -a current=$BASE_URL -a img=$BASE_URL/img -a leveloffset=${OFFSET} -a guide= -o html/${HTML}
}

if [ $# == 0 ]; then
   render ../exercise/lab_01.adoc
   render ../exercise/lab_02.adoc
   render ../exercise/lab_03.adoc
   render ../04_create_data_interactive.adoc create.html
   render ../05_cypher_deep_dive_starter.adoc starter.html
   render ../05_cypher_deep_dive_expert.adoc expert.html
   render ../05_cypher_deep_dive_advanced.adoc advanced.html
else
   render "$@"
fi

# s3cmd put -P --recursive html/* s3://guides.neo4j.com/intro/
