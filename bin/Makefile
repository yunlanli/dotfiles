.PHONY: link
link:
	for util in * ; do \
	  if [ $$util != "Makefile" ]; then \
	    echo "Installing $$util...\c"; \
	    sudo ln -s `pwd`/$$util /usr/local/bin/$$util; \
	    echo "OK"; \
	  fi \
  	done;
