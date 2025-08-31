<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Welcome to VideoCrypt</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    html, body {
      height: 100%;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(180deg, #0f0f20 0%, #1c1128 100%);
      color: #f3f3f3;
      overflow-x: hidden;
      scroll-behavior: smooth;
    }

    nav {
      background-color: #0a091a;
      display: flex; justify-content: space-between; align-items: center;
      padding: 15px 40px;
      position: fixed; top: 0; width: 100%; z-index: 1000;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 20px;
      font-weight: bold;
      color: #fff;
    }

    .logo svg {
      height: 32px;
      width: 32px;
    }

    .logo-text {
      font-size: 1.4em; font-weight: bold;
      background: linear-gradient(90deg, #c084fc, #f472b6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    nav ul {
      list-style: none; display: flex; gap: 25px;
    }

    nav ul li a {
      font-size: 1em; color: white; text-decoration: none;
    }

    nav ul li a:hover { text-decoration: underline; }

    .nav-buttons a {
      text-decoration: none; color: #fff;
      background: linear-gradient(90deg, #c084fc, #f472b6);
      padding: 8px 18px; border-radius: 6px;
      margin-left: 15px; font-size: 0.95em;
      transition: all 0.3s ease;
    }

    /* 👇 NEW HOVER EFFECT FOR LOGIN/REGISTER BUTTONS */
    .nav-buttons a:hover {
      background: linear-gradient(90deg, #f472b6, #c084fc);
      box-shadow: 0 4px 12px rgba(192, 132, 252, 0.5);
      transform: translateY(-1px);
    }

    .main {
      display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center;
      max-width: 1200px; margin: 120px auto 60px; padding: 20px;
    }

    .main-text { flex: 1; min-width: 300px; }
    .main-text h1 {
      font-size: 2.7em; margin-bottom: 15px;
      background: linear-gradient(90deg, #c792ff, #ffb6b9);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .main-text p {
      font-size: 1.2em; color: #ccc; margin-bottom: 30px;
    }

    .features {
      display: flex; flex-wrap: wrap; gap: 12px;
    }

    .feature-box {
      background-color: #1e1a33; padding: 14px 18px; border-radius: 12px;
      font-size: 1em; min-width: 220px;
      border: 1px solid #2e2a45;
    }

    .main-image { flex: 1; text-align: center; min-width: 300px; }
    .main-image img { max-width: 100%; height: auto; border-radius: 12px; }

    section { scroll-margin-top: 100px; }

    .pricing-section {
      background-color: #0c0a1f; padding: 60px 20px;
    }

    .pricing-title { text-align: center; font-size: 32px; margin-bottom: 40px; }

    .pricing-grid {
      display: flex; flex-wrap: wrap; gap: 24px; justify-content: center;
    }

    .pricing-card {
      background-color: #1c1a35; border-radius: 16px;
      padding: 30px; width: 260px; text-align: center;
      transition: all 0.3s ease; border: 2px solid transparent;
    }

    .pricing-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 0 20px rgba(124, 58, 237, 0.4);
      border-color: #7c3aed;
    }

    .pricing-card h3 { font-size: 20px; }
    .pricing-card h2 { margin: 10px 0; font-size: 26px; }
    .pricing-card p { font-size: 14px; }

    .pricing-card ul {
      text-align: left; font-size: 13px; margin-top: 20px; list-style: none; padding-left: 0; color: #ccc;
    }

    .pricing-card ul li::before {
      content: "✔ "; color: #7c3aed;
    }

    .pricing-card a {
      display: inline-block; margin-top: 20px;
      background-color: #7c3aed; padding: 10px 20px;
      border-radius: 8px; color: white; text-decoration: none;
    }

    .contact-section {
      background-color: #141122; color: #ccc; padding: 80px 20px;
    }

    .contact-form {
      border: 1px solid #333; border-radius: 12px;
      padding: 40px; max-width: 700px; margin: auto;
      background-color: #1c1a2e;
    }

    .contact-form input, .contact-form textarea {
      width: 100%; padding: 12px; border: 1px solid #555;
      border-radius: 6px; margin-top: 8px; background-color: #2a273f; color: #fff;
    }

    .contact-form label { font-weight: 600; }
    .contact-form button {
      background: linear-gradient(90deg, #c084fc, #f472b6);
      color: white; padding: 14px 30px; border: none; border-radius: 6px;
      font-size: 1em; cursor: pointer; margin-top: 15px;
    }

    .footer {
      background-color: #0a091a; color: #ccc;
      padding: 60px 40px 20px;
    }

    .footer-container {
      display: flex; flex-wrap: wrap; justify-content: space-between;
      max-width: 1200px; margin: 0 auto;
    }

    .footer-column {
      flex: 1; min-width: 200px; margin-bottom: 30px;
    }

    .footer-column h3 {
      border-bottom: 2px solid #c084fc; padding-bottom: 8px;
      margin-bottom: 16px; color: white;
    }

    .footer-column ul { list-style: none; padding: 0; }
    .footer-column ul li {
      margin-bottom: 10px; cursor: pointer;
      transition: color 0.3s ease;
    }

    .footer-column ul li:hover {
      color: #fff;
    }

    .social-icons {
      display: flex; gap: 16px; margin-top: 10px;
    }

    .social-icons a {
      color: #ccc; font-size: 20px; transition: color 0.3s ease;
    }

    .social-icons a:hover {
      color: #c084fc;
    }

    .footer-bottom {
      text-align: center; margin-top: 40px; font-size: 0.9em; color: #888;
    }
  </style>
</head>
<body>

  <!-- NAVBAR -->
  <nav>
    <div class="logo">
      <svg width="32" height="32" viewBox="0 0 1600 1600" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M1250.12 576.498c-.11 89.997-36 176.267-99.79 239.83l-.01-.007-226.282 225.489c-7.841 7.82-20.58 7.84-27.927-.44-55.015-61.995-85.587-142.175-85.49-225.478.106-89.997 36-176.267 99.787-239.83l.007.007 206.745-206.014c18.63-18.569 49.12-18.702 64.92 2.324 43.99 58.525 68.12 130.089 68.04 204.119zM440.552 817.702c-63.787-63.563-99.682-149.833-99.787-239.83-.087-74.03 24.048-145.594 68.035-204.119 15.803-21.026 46.294-20.893 64.928-2.324l206.741 206.016.006-.007c63.787 63.564 99.681 149.833 99.787 239.831.097 83.302-30.475 163.483-85.49 225.471-7.347 8.28-20.086 8.26-27.927.45L440.558 817.696l-.006.006zM1141.82 1221.19c-16.63 20.39-47.04 20.21-65.63 1.59l-127.698-127.84c-7.836-7.85-7.821-20.56.033-28.39l212.095-211.345c7.84-7.813 20.62-7.859 27.54.784 36.81 45.996 51.29 109.566 40.34 179.551-10.01 64.06-40.65 129.19-86.68 185.65zM514.696 1224.16c-18.594 18.61-49.002 18.79-65.626-1.6-46.036-56.46-76.672-121.58-86.687-185.64-10.943-69.992 3.531-133.562 40.342-179.558 6.916-8.642 19.703-8.597 27.544-.784l212.092 211.352c7.854 7.82 7.868 20.54.033 28.38l-127.698 127.85z" fill="#fff"/>
    </svg>
      <span class="logo-text">VideoCrypt</span>
    </div>
    <ul>
      <li><a href="#products">Products</a></li>
      <li><a href="#pricing">Pricing</a></li>
      <li><a href="#company">Company</a></li>
      <li><a href="#contact">Contact</a></li>
    </ul>
    <div class="nav-buttons">
      <a href="login.jsp">Login</a>
      <a href="register.jsp">Register</a>
    </div>
  </nav>

  <!-- HERO SECTION -->
  <section id="products" class="main">
    <div class="main-text">
      <h1>Next Gen Secured and Interactive Video Management Solution</h1>
      <p>Go from idea to stream with secure, scalable, and interactive tools.</p>
      <div class="features">
        <div class="feature-box">Live Streaming</div>
        <div class="feature-box">Multi-DRM</div>
        <div class="feature-box">eLearning App</div>
        <div class="feature-box">Customizable OTT Platform</div>
        <div class="feature-box">Video On Demand</div>
        <div class="feature-box">Ad Monetization</div>
      </div>
    </div>
    <div class="main-image">
      <img src="images/ob-bg.png" alt="VideoCrypt Interface">
    </div>
  </section>

  <!-- PRICING SECTION -->
  <section id="pricing" class="pricing-section">
    <h2 class="pricing-title">Choose Your Plan</h2>
    <div class="pricing-grid">
      <div class="pricing-card">
        <h3>Basic</h3>
        <h2>$9/mo</h2>
        <p>Starter plan for individuals</p>
        <ul>
          <li>1 Channel</li>
          <li>10 GB Storage</li>
          <li>Email Support</li>
        </ul>
        <a href="#">Get Started</a>
      </div>
      <div class="pricing-card">
        <h3>Standard</h3>
        <h2>$29/mo</h2>
        <p>Best for small teams</p>
        <ul>
          <li>5 Channels</li>
          <li>100 GB Storage</li>
          <li>Priority Support</li>
        </ul>
        <a href="#">Get Started</a>
      </div>
      <div class="pricing-card">
        <h3>Enterprise</h3>
        <h2>Contact Us</h2>
        <p>Custom solution</p>
        <ul>
          <li>Unlimited Channels</li>
          <li>Custom Storage</li>
          <li>24/7 Support</li>
        </ul>
        <a href="#">Contact Sales</a>
      </div>
    </div>
  </section>

  <!-- CONTACT SECTION -->
<section id="contact" class="contact-section">
  <div style="max-width: 1200px; margin: auto; text-align: center;">
    <h2 style="font-size: 32px; margin-bottom: 40px;">Contact Us</h2>
    <p>Have a question, partnership idea, or need support? We'd love to hear from you!</p><br><br>
    <div class="contact-form">
      <form action="ContactServlet" method="post">
        <div style="margin-bottom: 20px;">
          <label for="name">Your Name</label><br>
          <input type="text" id="name" name="name" required>
        </div>
        <div style="margin-bottom: 20px;">
          <label for="email">Your Email</label><br>
          <input type="email" id="email" name="email" required>
        </div>
        <div style="margin-bottom: 20px;">
          <label for="message">Message</label><br>
          <textarea id="message" name="message" rows="5" required></textarea>
        </div>
        <button type="submit">Send Message</button>
      </form>
    </div>
  </div>
</section>

  <!-- FOOTER -->
  <!-- FOOTER -->
  <div class="footer" id="company">
    <div class="footer-container">
      <div class="footer-column">
        <h3>Company</h3>
        <ul>
          <li>About Us</li>
          <li>Careers</li>
          <li>Press</li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Products</h3>
        <ul>
          <li>Live Streaming</li>
          <li>Video On Demand</li>
          <li>DRM Security</li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Support</h3>
        <ul>
          <li>Help Center</li>
          <li>Contact Support</li>
          <li>Privacy Policy</li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Follow Us</h3>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      &copy; 2025 VideoCrypt. All rights reserved.
    </div>
  </div>

</body>
</html>
