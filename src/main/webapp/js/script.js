// Form validation: Check for empty fields before submitting
function validateForm(formId) {
    const form = document.getElementById(formId);
    const inputs = form.querySelectorAll("input[type='text'], input[type='password'], input[type='file']");

    for (let input of inputs) {
        if (input.value.trim() === "") {
            alert("Please fill out all fields.");
            input.focus();
            return false;
        }
    }
    return true;
}

// Confirm delete action
function confirmDelete(videoTitle) {
    return confirm("Are you sure you want to delete the video: '" + videoTitle + "'?");
}

// Toggle password visibility
function togglePassword(inputId, iconId) {
    const passwordField = document.getElementById(inputId);
    const icon = document.getElementById(iconId);

    if (passwordField.type === "password") {
        passwordField.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        passwordField.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}

// Success message auto-hide after 3 seconds
function hideMessageAfterDelay() {
    const msg = document.getElementById("msg");
    if (msg) {
        setTimeout(() => {
            msg.style.display = "none";
        }, 3000);
    }
}

// Call this on window load to auto-hide messages if present
window.onload = hideMessageAfterDelay;
