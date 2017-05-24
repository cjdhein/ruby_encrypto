# Uses the Vigenère cipher to encrypt and decrypt a text file.
# (See https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher for more info)


# encrypts the provided file using the key provided
# params: 	filename -> the text file to be encrypted
#			key -> the key being used to encrypt
def encrypt(filename, key)
	
	_original = File.open(filename, "r")
	_encrypted = File.open("encrypted.txt", "w+")
	
	# initialize the keyword as an encryption key
	_key = EncryptionKey.new(key)
	
	linecount =  1
	
	# loop through each line, and then each character, modifying it by the current key value
	# then write the modified character to the output file
	_original.each do |line|
		charcount = 1
		line.split("").each do |originalChar|
			
			temp = originalChar.ord
			temp = (temp + _key.nextModVal()) % 256			
			encryptedChar = temp.chr
			_encrypted << encryptedChar
			charcount += 1
		end
		linecount += 1
	end
	
end


# decrypts the provided file using the key provided
# params: 	filename -> the text file to be decrypted
#			key -> the key being used to decrypt
def decrypt(filename, key)
	
	_decrypted = File.open("decrypted.txt", "w+")
	_encrypted = File.open(filename, "r")
	
	# initialize the keyword as an encryption key
	_key = EncryptionKey.new(key)
	
	
	# loop through each line, and then each character, modifying it by the current key value
	# then write the modified character to the output file	
	_encrypted.each do |line|
		line.split("").each do |encryptedChar|
			temp = encryptedChar.ord
			temp = temp - _key.nextModVal()
			
			if temp < 0
				temp = temp + 256
			end
			decryptedChar = temp.chr
			_decrypted << decryptedChar
		end
	end
	
end


# object representing the encryption keyword being used
class EncryptionKey
	
	def initialize(key)
		@keyword = key
		@iterator = 0
		@keyLength = @keyword.length
		@valArray = Array.new
		@keyword.split("").each do |char|
			@valArray.push(char.ord)
		end
	end
	
	# returns the ascii integer value of the character the iterator is pointing to and then increments the iterator
	def nextModVal()
		temp = @valArray[@iterator]
		
		if @iterator == (@keyLength - 1)
			@iterator = 0
		else
			@iterator += 1
		end
		
		return temp
	end
	
	def getKeyword()
		return @keyword
	end
	
	def getValArray()
		return @valArray
	end
	
	def getKeyLength()
		return @keyLength
	end
end



input = ARGV

if input.length != 3
	abort("missing arguments\nusage: encrypto.rb {option | filename | keyword} \n\toption: 0 for decrypt, 1 for encrypt")
	
end

if input[0].to_i != 0 && input[0].to_i != 1
	abort("invalid option")
end

if !(File.file?(input[1]))
	abort("file not found")
end

file = input[1]

key = input[2]

if input[0].to_i == 1 
	encrypt(file,key)
else
	decrypt(file,key)
end