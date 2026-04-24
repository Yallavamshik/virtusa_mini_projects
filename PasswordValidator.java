import java.util.Scanner;

public class PasswordValidator {

    // Method to validate password
    public static boolean isValidPassword(String password) {

        //Check length FIRST
        if (password.length() < 8) {
            System.out.println("Too short \"minimum 8 characters required\"");
            return false;
        }
        boolean hasUppercase = false;
        boolean hasDigit = false;

        //Loop through characters
        for (int i = 0; i < password.length(); i++) {
            char ch = password.charAt(i);
            if (Character.isUpperCase(ch)) {
                hasUppercase = true;
            }
            if (Character.isDigit(ch)) {
                hasDigit = true;
            }
        }

        //Feedback messages
        if (!hasUppercase) {
            System.out.println(" Missing an uppercase letter");
        }
        if (!hasDigit) {
            System.out.println(" Missing a digit");
        }

        //Final result
        return hasUppercase && hasDigit;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String password;

        // Retry using while loop
        while (true) {
            System.out.print("Enter your password: ");
            password = scanner.nextLine();

            if (isValidPassword(password)) {
                System.out.println(" Congratulations You created a strong password");
                break;
            } else {
                System.out.println("Please try again.\n");
            }
        }

        scanner.close();
    }
}