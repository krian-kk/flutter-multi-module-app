import android.util.Base64
import java.io.UnsupportedEncodingException
import java.security.InvalidAlgorithmParameterException
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import javax.crypto.BadPaddingException
import javax.crypto.Cipher
import javax.crypto.IllegalBlockSizeException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

class CryptLib {
    /**
     * Encryption mode enumeration
     */
    private enum class EncryptMode {
        ENCRYPT, DECRYPT
    }

    // cipher to be used for encryption and decryption
    private val _cx: Cipher

    // encryption key and initialization vector
    private val _key: ByteArray
    private val _iv: ByteArray

    init {
        // initialize the cipher with transformation AES/CBC/PKCS5Padding
        _cx = Cipher.getInstance("AES/CBC/PKCS5Padding")
        _key = ByteArray(32) //256 bit key space
        _iv = ByteArray(16) //128 bit IV
    }

    /**
     *
     * @param inputText Text to be encrypted or decrypted
     * @param encryptionKey Encryption key to used for encryption / decryption
     * @param mode specify the mode encryption / decryption
     * @param initVector Initialization vector
     * @return encrypted or decrypted bytes based on the mode
     * @throws UnsupportedEncodingException
     * @throws InvalidKeyException
     * @throws InvalidAlgorithmParameterException
     * @throws IllegalBlockSizeException
     * @throws BadPaddingException
     */
    @kotlin.Throws(
        UnsupportedEncodingException::class,
        java.security.InvalidKeyException::class,
        InvalidAlgorithmParameterException::class,
        IllegalBlockSizeException::class,
        BadPaddingException::class
    )
    private fun encryptDecrypt(
        inputText: String, encryptionKey: String,
        mode: EncryptMode, initVector: String
    ): ByteArray {
        var len: Int =
            encryptionKey.toByteArray(charset("UTF-8")).size // length of the key	provided
        if (encryptionKey.toByteArray(charset("UTF-8")).size > _key.size) len = _key.size
        var ivlength: Int = initVector.toByteArray(charset("UTF-8")).size
        if (initVector.toByteArray(charset("UTF-8")).size > _iv.size) ivlength = _iv.size
        java.lang.System.arraycopy(encryptionKey.toByteArray(charset("UTF-8")), 0, _key, 0, len)
        java.lang.System.arraycopy(initVector.toByteArray(charset("UTF-8")), 0, _iv, 0, ivlength)
        val keySpec = SecretKeySpec(
            _key,
            "AES"
        ) // Create a new SecretKeySpec for the specified key data and algorithm name.
        val ivSpec =
            IvParameterSpec(_iv) // Create a new IvParameterSpec instance with the bytes from the specified buffer iv used as initialization vector.

        // encryption
        return if (mode == EncryptMode.ENCRYPT) {
            // Potentially insecure random numbers on Android 4.3 and older. Read for more info.
            // https://android-developers.blogspot.com/2013/08/some-securerandom-thoughts.html
            _cx.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec) // Initialize this cipher instance
            _cx.doFinal(inputText.toByteArray(charset("UTF-8"))) // Finish multi-part transformation (encryption)
        } else {
            _cx.init(Cipher.DECRYPT_MODE, keySpec, ivSpec) // Initialize this cipher instance
            val decodedValue: ByteArray = Base64.decode(inputText.toByteArray(), Base64.DEFAULT)
            _cx.doFinal(decodedValue) // Finish multi-part transformation (decryption)
        }
    }

    @kotlin.Throws(java.lang.Exception::class)
    fun encryptPlainText(plainText: String, key: String, iv: String): String {
        val bytes = encryptDecrypt(plainText, SHA256(key, 32), EncryptMode.ENCRYPT, iv)
        return Base64.encodeToString(bytes, Base64.DEFAULT)
    }

    @kotlin.Throws(java.lang.Exception::class)
    fun decryptCipherText(cipherText: String, key: String, iv: String): String {
        val bytes = encryptDecrypt(cipherText, SHA256(key, 32), EncryptMode.DECRYPT, iv)
        return String(bytes)
    }

    @kotlin.Throws(java.lang.Exception::class)
    fun encryptPlainTextWithRandomIV(plainText: String, key: String): String {
        val bytes = encryptDecrypt(
            generateRandomIV16() + plainText,
            SHA256(key, 32),
            EncryptMode.ENCRYPT,
            generateRandomIV16()
        )
        return Base64.encodeToString(bytes, Base64.DEFAULT)
    }

    @kotlin.Throws(java.lang.Exception::class)
    fun decryptCipherTextWithRandomIV(cipherText: String, key: String): String {
        val bytes =
            encryptDecrypt(cipherText, SHA256(key, 32), EncryptMode.DECRYPT, generateRandomIV16())
        val out = String(bytes)
        return out.substring(16, out.length)
    }

    /**
     * Generate IV with 16 bytes
     * @return
     */
    fun generateRandomIV16(): String {
        val ranGen: java.security.SecureRandom = java.security.SecureRandom()
        val aesKey = ByteArray(16)
        ranGen.nextBytes(aesKey)
        val result = StringBuilder()
        for (b in aesKey) {
            result.append(String.format("%02x", b)) //convert to hex
        }
        return if (16 > result.toString().length) {
            result.toString()
        } else {
            result.toString().substring(0, 16)
        }
    }

    companion object {
        /***
         * This function computes the SHA256 hash of input string
         * @param text input text whose SHA256 hash has to be computed
         * @param length length of the text to be returned
         * @return returns SHA256 hash of input text
         * @throws NoSuchAlgorithmException
         * @throws UnsupportedEncodingException
         */
        @kotlin.Throws(NoSuchAlgorithmException::class, UnsupportedEncodingException::class)
        private fun SHA256(text: String, length: Int): String {
            val resultString: String
            val md: MessageDigest = MessageDigest.getInstance("SHA-256")
            md.update(text.toByteArray(charset("UTF-8")))
            val digest: ByteArray = md.digest()
            val result = StringBuilder()
            for (b in digest) {
                result.append(String.format("%02x", b)) //convert to hex
            }
            resultString = if (length > result.toString().length) {
                result.toString()
            } else {
                result.toString().substring(0, length)
            }
            return resultString
        }
    }
}