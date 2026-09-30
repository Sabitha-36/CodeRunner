<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Home.aspx.vb" Inherits="Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Code Runner - Dashboard</title>
    <style type="text/css">
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            width: 100%; height: 100vh; overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(180deg, #184c63 0%, #2f9ea6 45%, #58cdc9 100%) !important;
            position: relative;
        }

        /* Top Navigation Bar */
        .top-nav {
            position: absolute; top: 0; left: 0; width: 100%; height: 55px;
            background-color: #1a4258; display: flex; justify-content: space-between;
            align-items: center; padding: 0 25px; z-index: 20; box-shadow: 0 2px 8px rgba(0,0,0,0.25);
        }
        .nav-brand { font-size: 24px; font-weight: 800; }
        .brand-yellow { color: #facc15; }
        .brand-green { color: #4ade80; }

        .nav-right { display: flex; align-items: center; gap: 15px; }
        .user-badge {
            display: flex; align-items: center; gap: 8px;
            background: rgba(255, 255, 255, 0.15); padding: 5px 14px; border-radius: 20px;
        }
        .user-avatar { font-size: 16px; color: #4ade80; }
        .user-name { font-size: 13px; font-weight: 700; color: #ffffff; }

        .btn-logout {
            background-color: #ef4444 !important; color: #ffffff !important;
            border: none; padding: 6px 14px; border-radius: 8px; font-size: 12px;
            font-weight: 700; cursor: pointer; transition: 0.2s;
        }
        .btn-logout:hover { background-color: #dc2626 !important; }

        /* Dashboard Container Layout */
        .dashboard-container {
            width: 100%; height: 100vh; display: flex;
            justify-content: center; align-items: center;
            position: relative; z-index: 10; padding: 60px 20px 0;
        }

        .dashboard-card {
            background-color: #ffffff !important; width: 750px;
            padding: 30px; border-radius: 24px;
            box-shadow: 0 16px 36px rgba(0,0,0,0.25); text-align: center;
        }

        .welcome-title { font-size: 28px; font-weight: 900; color: #1e293b; margin-bottom: 5px; }
        .welcome-sub { font-size: 13px; color: #64748b; margin-bottom: 25px; font-weight: 600; }

        /* Grid Action Cards */
        .grid-options {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 25px;
        }
        .option-card {
            background: #f8fafc; border: 2px solid #e2e8f0; border-radius: 16px;
            padding: 20px; transition: all 0.2s ease-in-out; text-decoration: none; display: block;
        }
        .option-card:hover {
            transform: translateY(-4px); border-color: #3b82f6; box-shadow: 0 8px 16px rgba(59, 130, 246, 0.15);
        }
        .card-icon { font-size: 32px; margin-bottom: 10px; }
        .card-title { font-size: 16px; font-weight: 800; color: #0f172a; margin-bottom: 4px; }
        .card-desc { font-size: 11px; color: #64748b; line-height: 1.3; }

        /* Main Play Button */
        .btn-play-now {
            width: 100%; padding: 16px;
            background: linear-gradient(180deg, #ff9800 0%, #f57c00 100%) !important;
            color: #ffffff !important; border: none; border-radius: 14px;
            font-size: 18px; font-weight: 900; letter-spacing: 1px;
            cursor: pointer; box-shadow: 0 6px 16px rgba(245, 124, 0, 0.4); transition: 0.2s;
        }
        .btn-play-now:hover {
            background: linear-gradient(180deg, #fb8c00 0%, #e65100 100%) !important;
        }

        /* Pixel Environment Details */
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
        <!-- Top Navigation -->
        <div class="top-nav">
            <div class="nav-brand"><span class="brand-yellow">Code</span> <span class="brand-green">Runner</span></div>
            <div class="nav-right">
                <div class="user-badge">
                    <span class="user-avatar">🎮</span>
                    <asp:Label id="lblUsernameNav" runat="server" CssClass="user-name" Text="Player"></asp:Label>
                </div>
                <asp:Button ID="btnLogout" runat="server" Text="LOGOUT" CssClass="btn-logout" />
            </div>
        </div>

        <!-- Main Dashboard Card -->
        <div class="dashboard-container">
            <div class="dashboard-card">
                <h1 class="welcome-title">Welcome Back, <asp:Label ID="lblUsername" runat="server" Text="Runner"></asp:Label>!</h1>
                <p class="welcome-sub">Selected Character: <asp:Label ID="lblCharacter" runat="server" Text="RunnerOne" ForeColor="#10b981" Font-Bold="true"></asp:Label></p>

                <div class="grid-options">
                    <a href="../LevelPage/Levels.aspx" class="option-card">
                        <div class="card-icon">🏃‍</div>
                        <div class="card-title">Start Game</div>
                        <div class="card-desc">Select a level and star your coding run.</div>
                    </a>

                    <a href="../LeaderboardPage/Leaderboard.aspx" class="option-card">
                        <div class="card-icon">🏆</div>
                        <div class="card-title">Leaderboard</div>
                        <div class="card-desc">View global rankings and top code runners.</div>
                    </a>

                    <a href="../ProfilePage/Profile.aspx" class="option-card">
                        <div class="card-icon">⚙️</div>
                        <div class="card-title">Profile</div>
                        <div class="card-desc">View your profile and edit it.</div>
                    </a>
                </div>

                <asp:Button ID="btnPlayNow" runat="server" Text="PLAY NOW 🚀" CssClass="btn-play-now" />
            </div>
        </div>

        <!-- City Background -->
        <div class="building building-1"></div>
        <div class="building building-2"></div>
        <div class="building building-3"></div>
        <div class="building building-4"></div>
        <div class="ground-grid"></div>
    </form>
</body>
</html>