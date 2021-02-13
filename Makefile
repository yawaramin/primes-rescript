bundle.js : src/primes.js
	npx esbuild $< --bundle --minify --outfile=$@

src/primes.js : src/primes.ml
	npx bsb -make-world
