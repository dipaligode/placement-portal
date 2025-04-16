<?php

require 'email_helper.php';

session_start();
$db = new mysqli("localhost", "root", "", "my_placement_portal");

if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

$message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $message = "Invalid email format.";
    } else {
        $stmt = $db->prepare("SELECT email FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $encodedEmail = base64_encode($email);
            $resetLink = "http://localhost/my_placement_portal/reset-password.php?email=" . urlencode($encodedEmail);

            $emailBody = "
                <h3>Password Reset Request</h3>
                <p>Click the link below to reset your password:</p>
                <p><a href='$resetLink'>$resetLink</a></p>
                <p>If you didn't request this, ignore this email.</p>
            ";

            if (sendEmail($email, "Password Reset Request", $emailBody)) {
                $message = "Password reset email sent! Check your inbox.";
            } else {
                $message = "Failed to send email. Check SMTP settings.";
            }
        } else {
            $message = "No account found with that email.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>
    <p style="color: red;"><?php echo htmlspecialchars($message); ?></p>

    <form method="post">
        <label>Email:</label>
        <input type="email" name="email" required placeholder="Enter your email"><br><br>
        <button type="submit">Send Reset Link</button>
    </form>

    <a href="index.php">Back</a>
</body>
</html>
