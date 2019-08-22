#install.packages("openssl")
#install.packages("readr") # you only need to do this one time on your system
library(readr)
library(openssl)

input = "main.pdf"
output_cypher = "main_C.pdf"
output_uncypher = "uncypher.pdf"
private_key = "private key.txt"
public_key = "public key.txt"
  
# Génération d'une clé :
private_key = "private key.txt"
public_key = "public key.txt"

key = rsa_keygen()
pubkey = key$pubkey
write_ssh(pubkey, public_key)
write_pem(key, private_key)

#Encryption du message : 
input = "main.pdf"
crypted_output = "main_C.pdf"
crypted_key = "K1.txt"
file_iv = "iv.txt"

pubkey = read_pubkey(public_key)
  
# Encrypt data with AES
tempkey = rand_bytes(32)
iv = rand_bytes(16)
blob = aes_cbc_encrypt(input, tempkey, iv = iv) # Encryption du message
ciphertext = rsa_encrypt(tempkey, pubkey) # Encryption de la clé
write_file(x = blob, path = crypted_output)
write_file(x = ciphertext, path = crypted_key)
write_file(x = rawToChar(iv), path = file_iv)

# Decrypt
input = "Documentation.tar"
output = "CR.tar"
crypted_key = "K1.txt"
file_iv = "iv.txt"
private_key = "private key.txt"

iv = read_file_raw(file_iv)
blob = read_file_raw(input)
ciphertext = read_file_raw(crypted_key)

key = read_key(private_key)
tempkey = rsa_decrypt(ciphertext, key)
message = aes_cbc_decrypt(blob, tempkey, iv)
write_file(message, output)
