# Create two Hamming codes over the binary field GF(2), with codeword lengths 2^2-1=3 and 2^3-1=7 respectively
C1 = codes.HammingCode(GF(2), 2)
C2 = codes.HammingCode(GF(2), 3)

# Combine the two Hamming codes to form a product code
C_product = C1.product_code(C2)

# Generate a random data vector of appropriate length
data_blob = random_vector(C_product.base_field(), C_product.dimension()) 
print("data_blob: ",data_blob)

# Encode the data using the product code
encoded_blob = C_product.encode(data_blob)
print("encoded_blob: ",encoded_blob)

# Set the error rate for the communication channel
err = 3

# Create a communication channel with a static error rate
Chan = channels.StaticErrorRateChannel(C_product.ambient_space(), err)

# Transmit the encoded data through the channel, introducing errors
corrupted_blob = Chan.transmit(encoded_blob)
print("corrupted_blob: ", corrupted_blob)

# Decode the received data using the product code's decoding algorithm
decoded_blob = C_product.decode_to_code(corrupted_blob)
print("decoded_blob: ",decoded_blob)
print("Are the codes same? ", data_blob == decoded_blob)

# Unencode the decoded codeword to recover the original message
decoded_blob_msg = C_product.unencode(decoded_blob)
print("Are the messages same? ", decoded_blob_msg == data_blob)
