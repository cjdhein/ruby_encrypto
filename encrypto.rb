

def encrypt(filename, key)
	
	_original = File.open(filename, "r")
	_encrypted = File.open("encrypted.txt", "w+")
	_key = EncryptionKey.new(key)
	
	_original.each do |line|
		line.split("").each do |originalChar|
			temp = originalChar.ord
			temp = temp + _key.nextModVal()
			encryptedChar = temp.chr
			_encrypted << encryptedChar
		end
	end
	
end


def decrypt(filename, key)
	
	_decrypted = File.open("decrypted.txt", "w+")
	_encrypted = File.open(filename, "r")
	_key = EncryptionKey.new(key)
	
	_encrypted.each do |line|
		line.split("").each do |encryptedChar|
			temp = encryptedChar.ord
			temp = temp - _key.nextModVal()
			decryptedChar = temp.chr
			_decrypted << decryptedChar
		end
	end
	
end



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