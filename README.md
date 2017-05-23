# ruby_encrypto
Rudimentary text file encryption / decryption utility using a version of the vigenère cipher.

usage: ruby encrypto.rb {option | filename | keyword}
        
        option: 0 for decrypt, 1 for encrypt
        
        filename: name of text file to encrypt or decrypt
        
        keyword: the keyword used to encrypt the file

		
If encrypting the file, the output file will be called "encrypted.txt"

If decrypting the file, the output file will be called "decrypted.txt"