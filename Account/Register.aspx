<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Register.aspx.vb" Inherits="Account_Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Code Runner - Register</title>
    <style type="text/css">
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            width: 100%; height: 100vh; overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(180deg, #184c63 0%, #2f9ea6 45%, #58cdc9 100%) !important;
            position: relative;
        }
        .top-nav {
            position: absolute; top: 0; left: 0; width: 100%; height: 48px;
            background-color: #1a4258; display: flex; justify-content: space-between;
            align-items: center; padding: 0 20px; z-index: 20; box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        .nav-brand { font-size: 22px; font-weight: 800; }
        .brand-yellow { color: #facc15; }
        .brand-green { color: #4ade80; }
        .nav-user {
            display: flex; align-items: center; gap: 8px;
            background: rgba(255, 255, 255, 0.12); padding: 4px 12px; border-radius: 16px;
        }
        .user-avatar { font-size: 14px; color: #cbd5e1; }
        .user-info { display: flex; flex-direction: column; line-height: 1.1; }
        .user-status { font-size: 11px; font-weight: 700; color: #ffffff; }
        .user-sub { font-size: 9px; color: #94a3b8; }

        .badge {
            position: absolute; background: #ffffff !important; color: #1e293b !important;
            padding: 4px 10px; border-radius: 8px; font-size: 12px; font-weight: 700;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12); border: 1px solid #e2e8f0; z-index: 5;
        }
        .badge-1 { top: 16%; left: 8%; }
        .badge-2 { top: 65%; left: 10%; }
        .badge-3 { top: 40%; right: 26%; }
        .badge-4 { top: 22%; right: 8%; }
        .badge-5 { top: 72%; right: 12%; }

        .register-container {
            width: 100%; height: 100vh; display: flex; flex-direction: column;
            justify-content: center; align-items: center; position: relative; z-index: 10;
        }
        .register-card {
            background-color: #ffffff !important; width: 380px; padding: 28px 28px;
            border-radius: 20px; box-shadow: 0 16px 36px rgba(0,0,0,0.22); text-align: center;
        }
        .register-card h1 { font-size: 30px; font-weight: 900; margin-bottom: 2px; }
        .tagline { font-size: 12px; font-weight: 800; color: #334155; margin-bottom: 16px; }

        .form-group { text-align: left; margin-bottom: 12px; }
        .form-group label { display: block; font-size: 12px; font-weight: 700; color: #0f172a !important; margin-bottom: 4px; }
        .form-control {
            width: 100%; padding: 10px 12px; border-radius: 8px; border: 1px solid #dbeafe !important;
            background-color: #edf2f7 !important; color: #0f172a !important; font-size: 13px; outline: none;
        }
        .form-control:focus { border-color: #3b82f6 !important; background-color: #ffffff !important; }

        .btn-register {
            width: 100%; padding: 12px; background: linear-gradient(180deg, #22c55e 0%, #16a34a 100%) !important;
            color: #ffffff !important; border: none; border-radius: 10px; font-size: 15px; font-weight: 800;
            cursor: pointer; margin-top: 8px; box-shadow: 0 4px 12px rgba(34, 197, 94, 0.4);
        }
        .btn-register:hover { background: linear-gradient(180deg, #16a34a 0%, #15803d 100%) !important; }

        .card-footer { margin-top: 14px; font-size: 13px; font-weight: 700; color: #334155; }
        .login-link { color: #ff9800 !important; text-decoration: none; font-weight: 800; }
        .login-link:hover { text-decoration: underline; }

        .alert-msg {
            display: block; padding: 8px 12px; margin-bottom: 10px; border-radius: 8px;
            background-color: #ef4444; color: #ffffff; font-size: 12px; font-weight: 600;
        }

        .building { position: absolute; bottom: 40px; background-color: #2b5568; z-index: 1; }
        .building-1 { left: 5%; width: 35px; height: 110px; }
        .building-2 { left: 18%; width: 42px; height: 160px; }
        .building-3 { right: 20%; width: 32px; height: 130px; }
        .building-4 { right: 8%; width: 36px; height: 170px; }

        .ground-grid {
            position: absolute; bottom: 0; left: 0; width: 100%; height: 40px;
            background-color: #2b5568;
            background-image: 
                linear-gradient(to right, rgba(255,255,255,0.18) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(255,255,255,0.18) 1px, transparent 1px);
            background-size: 16px 16px; z-index: 2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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

        <div class="badge badge-1">&lt;CREATE&gt;</div>
        <div class="badge badge-2">While</div>
        <div class="badge badge-3">&lt;BUILD/&gt;</div>
        <div class="badge badge-4">if {}</div>
        <div class="badge badge-5">for {}</div>

        <div class="register-container">
            <div class="register-card">
                <h1><span class="brand-yellow">Code</span> <span class="brand-green">Runner</span></h1>
                <p class="tagline">Create Your Account</p>

                <asp:Label ID="lblMessage" runat="server" CssClass="alert-msg" Visible="false"></asp:Label>

                <div class="form-group">
                    <label>Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="CREATE ACCOUNT" CssClass="btn-register" />

                <div class="card-footer">
                    Already have an account? <a href="Login.aspx" class="login-link">LOGIN</a>
                </div>
            </div>
        </div>

        <div class="building building-1"></div>
        <div class="building building-2"></div>
        <div class="building building-3"></div>
        <div class="building building-4"></div>
        <div class="ground-grid"></div>
    </form>
</body>
</html>