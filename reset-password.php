<?php
session_start();
$db = new mysqli("localhost", "root", "", "my_placement_portal");

if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

$message = "";

if (!isset($_GET['email'])) {
    die("Invalid reset link.");
}

$email = base64_decode($_GET['email']);

$stmt = $db->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    die("Invalid or expired reset link.");
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $newPassword = trim($_POST['new_password']);
    $confirmPassword = trim($_POST['confirm_password']);

    if ($newPassword !== $confirmPassword) {
        $message = "Passwords do not match.";
    } elseif (!preg_match('/^(?=.*[A-Z])(?=.*\d).{8,}$/', $newPassword)) {
        $message = "Password must be at least 8 characters long, contain an uppercase letter, and a number.";
    } else {
        $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

        $updateStmt = $db->prepare("UPDATE users SET password = ? WHERE email = ?");
        $updateStmt->bind_param("ss", $hashedPassword, $email);
        if ($updateStmt->execute()) {
            $message = "Password updated successfully! <a href='index.php'>Login</a>";
        } else {
            $message = "Failed to update password. Try again.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Password</h2>
    <p style="color: red;"><?php echo $message; ?></p>

    <form method="post">
        <label>New Password:</label>
        <input type="password" name="new_password" required placeholder="Enter new password"><br><br>

        <label>Confirm Password:</label>
        <input type="password" name="confirm_password" required placeholder="Confirm new password"><br><br>

        <button type="submit">Reset Password</button>
    </form>

    <a href="index.php">Back</a>
</body>
</html>
