CHAPTERS = introduction sendmore sudoku nqueen applications methodology visualization minizinc

all: $(CHAPTERS)

.PHONY: all $(CHAPTERS)

$(CHAPTERS): 
	$(MAKE) -C $@

clean:
	for dir in $(CHAPTERS); do \
	$(MAKE) -C $$dir clean ;\
	done

