hw5.html: hw5.Rmd data/wawa/wawa.rds data/sheetz/sheetz.rds
	Rscript -e "library(rmarkdown); render('hw5.Rmd')"

data/wawa/wawa.rds: parse_wawa.R data/wawa/raw_wawa.rds
	Rscript parse_wawa.R

data/sheetz/sheetz.rds: parse_sheetz.R data/sheetz/raw_sheetz.rds
	Rscript parse_sheetz.R
	
data/wawa/raw_wawa.rds: get_wawa.R
	mkdir -p data/wawa; Rscript get_wawa.R

data/sheetz/raw_sheetz.rds: get_sheetz.R
	mkdir -p data/sheetz; Rscript get_sheetz.R

.PHONY: clean_html clean_data
clean_html:
	rm hw5.html

clean_data:
	rm -rf data/