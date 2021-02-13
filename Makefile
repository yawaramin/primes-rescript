bundle.js : src/primes.js
	npx esbuild $< --bundle --outfile=$@

src/primes.js : src/primes.ml
	npx bsb -make-world
