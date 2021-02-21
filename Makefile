DIR = _build
INPUT = master
OUTPUT = book

all:
	rubber --pdf --into ${DIR} --jobname ${OUTPUT} ${INPUT}

view:
	xdg-open ${DIR}/${OUTPUT}.pdf

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}/*; \
	fi; \

rclean:
	rubber --clean --into ${DIR} --jobname ${OUTPUT} ${INPUT}
