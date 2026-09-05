<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Account_Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Code Runner - Login</title>
    <style type="text/css">
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            width: 100%;
            height: 100vh;
            overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(180deg, #184c63 0%, #2f9ea6 45%, #58cdc9 100%) !important;
            position: relative;
        }

        /* Top Header Navigation Bar */
        .top-nav {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 48px;
            background-color: #1a4258;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            z-index: 20;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .nav-brand {
            font-size: 22px;
            font-weight: 800;
        }

        .brand-yellow { color: #facc15; }
        .brand-green { color: #4ade80; }

        .nav-user {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.12);
            padding: 4px 12px;
            border-radius: 16px;
        }

        .user-avatar {
            font-size: 14px;
            color: #cbd5e1;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            line-height: 1.1;
        }

        .user-status {
            font-size: 11px;
            font-weight: 700;
            color: #ffffff;
        }

        .user-sub {
            font-size: 9px;
            color: #94a3b8;
        }

        /* Floating Code Badges */
        .badge {
            position: absolute;
            background: #ffffff !important;
            color: #1e293b !important;
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            border: 1px solid #e2e8f0;
            z-index: 5;
        }

        .badge-1 { top: 18%; left: 8%; }
        .badge-2 { top: 62%; left: 13%; }
        .badge-3 { top: 42%; right: 27%; }
        .badge-4 { top: 28%; right: 8%; }
        .badge-5 { top: 68%; right: 15%; }

        /* Login Center Layout */
        .login-container {
            width: 100%;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 10;
        }

        .login-card {
            background-color: #ffffff !important;
            width: 360px;
            padding: 30px 28px;
            border-radius: 20px;
            box-shadow: 0 16px 36px rgba(0,0,0,0.22);
            text-align: center;
        }

        .login-card h1 {
            font-size: 32px;
            font-weight: 900;
            margin-bottom: 2px;
        }

        .tagline {
            font-size: 12px;
            font-weight: 800;
            color: #334155;
            margin-bottom: 20px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 14px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #0f172a !important;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 11px 14px;
            border-radius: 8px;
            border: 1px solid #dbeafe !important;
            background-color: #edf2f7 !important;
            color: #0f172a !important;
            font-size: 13px;
            outline: none;
        }

        .form-control:focus {
            border-color: #3b82f6 !important;
            background-color: #ffffff !important;
        }

        .forgot-wrapper {
            text-align: right;
            margin-top: 6px;
        }

        .forgot-link {
            font-size: 12px;
            color: #475569 !important;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(180deg, #ff9800 0%, #f57c00 100%) !important;
            color: #ffffff !important;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 800;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 4px 12px rgba(245, 124, 0, 0.4);
        }

        .btn-login:hover {
            background: linear-gradient(180deg, #fb8c00 0%, #e65100 100%) !important;
        }

        .card-footer {
            margin-top: 16px;
            font-size: 13px;
            font-weight: 700;
            color: #334155;
        }

        .external-footer {
            margin-top: 14px;
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
        }

        .create-link {
            color: #22c55e !important;
            text-decoration: none;
            font-weight: 800;
        }

        .create-link:hover {
            text-decoration: underline;
        }

        .alert-msg {
            display: block;
            padding: 8px 12px;
            margin-bottom: 12px;
            border-radius: 8px;
            background-color: #ef4444;
            color: #ffffff;
            font-size: 12px;
            font-weight: 600;
        }

        /* Pixel City Landscape */
        .building {
            position: absolute;
            bottom: 40px;
            background-color: #2b5568;
            z-index: 1;
        }

        .building-1 { left: 5%; width: 35px; height: 110px; }
        .building-2 { left: 18%; width: 42px; height: 160px; }
        .building-3 { right: 20%; width: 32px; height: 130px; }
        .building-4 { right: 8%; width: 36px; height: 170px; }

        .ground-grid {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 40px;
            background-color: #2b5568;
            background-image: 
                linear-gradient(to right, rgba(255,255,255,0.18) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(255,255,255,0.18) 1px, transparent 1px);
            background-size: 16px 16px;
            z-index: 2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="top-nav">
            <div class="nav-brand"><span class="brand-yellow">Code</span> <span class="brand-green">Runner</span></div>
            <div class="nav-user">
                <div class="user-avatar">👤</div>
                <div class="user-info">
                    <span class="user-status">Not Logged In</span>
                    <span class="user-sub">Re-solve, IF</span>
                </div>
            </div>
        </div>

        <!-- Floating Tokens -->
        <div class="badge badge-1">&lt;CODE&gt;</div>
        <div class="badge badge-2">if()</div>
        <div class="badge badge-3">&lt;/&gt;</div>
        <div class="badge badge-4">{}</div>
        <div class="badge badge-5">{ code }</div>

        <!-- Card Container -->
        <div class="login-container">
            <div class="login-card">
                <h1><span class="brand-yellow">Code</span> <span class="brand-green">Runner</span></h1>
                <p class="tagline">Run • Catch • Code • Solve</p>

                <asp:Label ID="lblMessage" runat="server" CssClass="alert-msg" Visible="false"></asp:Label>

                <div class="form-group">
                    <label>Email or Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Email or Username"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                    <div class="forgot-wrapper">
                        <a href="#" class="forgot-link">Forgot Password?</a>
                    </div>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="btn-login" OnClick="btnLogin_Click" UseSubmitBehavior="false"/>

                <div class="card-footer">
                    New player? <a href="Register.aspx" class="create-link">CREATE ACCOUNT</a>
                </div>
            </div>

           
        </div>

        <!-- Pixel Background Elements -->
        <div class="building building-1"></div>
        <div class="building building-2"></div>
        <div class="building building-3"></div>
        <div class="building building-4"></div>
        <div class="ground-grid"></div>
    </form>
</body>
</html>