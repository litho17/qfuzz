import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Arrays;

import edu.cmu.sv.kelinci.Kelinci;
import edu.cmu.sv.kelinci.Mem;

public class ModPow1_FuzzDriver {

    public static void main(String[] args) {

        if (args.length != 1) {
            System.out.println("Expects file name as parameter");
            return;
        }

        BigInteger secret1_exponent = null;
        BigInteger secret2_exponent = null;
        BigInteger public_base = null;
        BigInteger public_modulus = null;

        int n = 4; // how many BigInteger variables
        int maxM = Integer.BYTES; // size of each BigInteger in terms of bytes

        int maxNumVal = n * maxM;

        byte[] secret1_bytes = null;
        byte[] secret2_bytes = null;
        byte[] public_base_bytes = null;
        byte[] public_modulus_bytes = null;

        // Read all inputs.
        byte[] bytes;
        try (FileInputStream fis = new FileInputStream(args[0])) {

            // Determine size of byte array.
            try {
                int fileSize = Math.toIntExact(fis.getChannel().size());
                bytes = new byte[Math.min(fileSize, maxNumVal)];
            } catch (ArithmeticException e) {
                bytes = new byte[maxNumVal];
            }

            if (bytes.length < n) {
                throw new RuntimeException("too less data");
            } else {
                fis.read(bytes);
            }
        } catch (IOException e) {
            System.err.println("Error reading input");
            e.printStackTrace();
            return;
        }

        int m = bytes.length / n;

        secret1_bytes = Arrays.copyOfRange(bytes, 0, m);
        secret2_bytes = Arrays.copyOfRange(bytes, m, 2 * m);
        public_base_bytes = Arrays.copyOfRange(bytes, 2 * m, 3 * m);
        public_modulus_bytes = Arrays.copyOfRange(bytes, 3 * m, 4 * m);

        /* Use only positive values, first value determines the signum. */
        if (secret1_bytes[0] < 0) {
            secret1_bytes[0] = (byte) (secret1_bytes[0] * (-1) - 1);
        }
        if (secret2_bytes[0] < 0) {
            secret2_bytes[0] = (byte) (secret2_bytes[0] * (-1) - 1);
        }
        if (public_base_bytes[0] < 0) {
            public_base_bytes[0] = (byte) (public_base_bytes[0] * (-1) - 1);
        }
        if (public_modulus_bytes[0] < 0) {
            public_modulus_bytes[0] = (byte) (public_modulus_bytes[0] * (-1) - 1);
        }

        /* Ensure secret1 and secret2 has same bit length */
        secret1_exponent = new BigInteger(secret1_bytes);
        secret2_exponent = new BigInteger(secret2_bytes);
        // fix to 1 if number is zero, BigInteger will return 0 which is wrong, might be a bug in JDK.
        int bitLength1 = (secret1_exponent.equals(BigInteger.ZERO) ? 1 : secret1_exponent.bitLength());
        int bitLength2 = (secret2_exponent.equals(BigInteger.ZERO) ? 1 : secret2_exponent.bitLength());
        if (bitLength1 != bitLength2) {

            /*
             * Trim bigger number to smaller bit length and ensure there is the 1 in the beginning of the bit
             * representation, otherwise the zero would be trimmed again by the BigInteger constructor and hence it
             * would have a smaller bit length.
             */
            if (bitLength1 > bitLength2) {
                String bitStr1 = secret1_exponent.toString(2);
                bitStr1 = "1" + bitStr1.substring(bitLength1 - bitLength2 + 1);
                secret1_exponent = new BigInteger(bitStr1, 2);
            } else {
                String bitStr2 = secret2_exponent.toString(2);
                bitStr2 = "1" + bitStr2.substring(bitLength2 - bitLength1 + 1);
                secret2_exponent = new BigInteger(bitStr2, 2);
            }
        }
        bitLength1 = (secret1_exponent.equals(BigInteger.ZERO) ? 1 : secret1_exponent.bitLength());
        bitLength2 = (secret2_exponent.equals(BigInteger.ZERO) ? 1 : secret2_exponent.bitLength());

        /* We do not care about the bit length of the public values. */
        public_base = new BigInteger(public_base_bytes);
        public_modulus = new BigInteger(public_modulus_bytes); // TODO may fix the modulus value here
        // Ensure that modulus is not zero.
        if (public_modulus.equals(BigInteger.ZERO)) {
            public_modulus = BigInteger.ONE;
        }

        System.out.println("secret1_exponent=" + secret1_exponent);
        System.out.println("secret1_exponent.bitlength=" + secret1_exponent.bitLength());
        System.out.println("secret1_exponent=" + secret1_exponent.toString(2));
        System.out.println("secret2_exponent=" + secret2_exponent);
        System.out.println("secret2_exponent.bitlength=" + secret2_exponent.bitLength());
        System.out.println("secret2_exponent=" + secret2_exponent.toString(2));
        System.out.println("public_base=" + public_base);
        System.out.println("public_base.bitlength=" + public_base.bitLength());
        System.out.println("public_modulus=" + public_modulus);
        System.out.println("public_modulus.bitlength=" + public_modulus.bitLength());

        Mem.clear(true);
        BigInteger result1 = ModPow1.modPow1_unsafe(public_base, secret1_exponent, public_modulus, bitLength1);
        long cost1 = Mem.instrCost;
        System.out.println("result1=" + result1);
        System.out.println("cost1=" + cost1);

        Mem.clear(false);
        BigInteger result2 = ModPow1.modPow1_unsafe(public_base, secret2_exponent, public_modulus, bitLength2);

        long cost2 = Mem.instrCost;
        System.out.println("result2=" + result2);
        System.out.println("cost2=" + cost2);

        Kelinci.addCost(Math.abs(cost1 - cost2));

        System.out.println("Done.");

        // System.out.println("res1_bigint=" + public_base.modPow(secret1_exponent, public_modulus));
        // System.out.println("res2_bigint=" + public_base.modPow(secret2_exponent, public_modulus));

    }

}
