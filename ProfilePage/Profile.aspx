<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Profile.aspx.vb" Inherits="ProfilePage.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Code Runner - Player Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            width: 100%;
            min-height: 100vh;
            font-family: 'Nunito', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(180deg, #184c63 0%, #2f9ea6 45%, #58cdc9 100%) !important;
                        background-attachment: fixed;
            color: #2c3e50;
        }

        form {
            width: 100%;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 20px 60px 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Header Navigation Bar */
        .top-navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 30px;
            background-color: #0d3238;
            border-bottom: 2px solid #1a515a;
        }

        /* Card Container Styles matching Admin Theme */
        .profile-header, 
        .xp-card, 
        .stat-card, 
        .panel {
            background-color: #ffffff !important;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
            border: 1px solid #e2e8f0;
        }

        /* Profile Header Box */
        .profile-header {
            padding: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info { display: flex; align-items: center; gap: 20px; }
        .avatar { 
            width: 80px; 
            height: 80px; 
            background: #20c997; 
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 40px; 
            color: #ffffff;
        }
        .username { 
            font-family: 'Fredoka One', cursive; 
            font-size: 32px; 
            color: #0f2c31; 
        }
        .subtitle { 
            font-weight: 700; 
            color: #64748b; 
            font-size: 14px; 
            margin-bottom: 6px; 
        }
        .badge-level { 
            background: #ffc107; 
            color: #0f2c31; 
            font-family: 'Fredoka One', cursive; 
            padding: 4px 14px; 
            border-radius: 12px; 
            font-size: 12px; 
            display: inline-block; 
        }
        .rank-box { text-align: right; }
        .rank-title { font-size: 12px; font-weight: 800; color: #64748b; text-transform: uppercase; }
        .rank-num { font-family: 'Fredoka One', cursive; font-size: 36px; color: #20c997; }

        /* XP Progress Bar Box */
        .xp-card { padding: 20px 25px; }
        .xp-header { 
            display: flex; 
            justify-content: space-between; 
            font-weight: 800; 
            font-size: 13px; 
            color: #64748b; 
            margin-bottom: 8px; 
            text-transform: uppercase; 
        }
        .progress-bg { background: #e2e8f0; height: 14px; border-radius: 10px; overflow: hidden; }
        .progress-fill { background: #20c997; height: 100%; border-radius: 10px; }

        /* Grid Section Titles */
        .section-title { 
            font-family: 'Fredoka One', cursive; 
            font-size: 18px; 
            color: #ffffff; 
            letter-spacing: 0.5px; 
            margin-bottom: 12px; 
            text-transform: uppercase; 
        }

        .panel-title {
            font-family: 'Fredoka One', cursive; 
            font-size: 18px; 
            color: #0f2c31; 
            margin-bottom: 15px; 
            text-transform: uppercase; 
        }

        /* Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; }
        .stat-card { padding: 20px; text-align: center; }
        .stat-icon { font-size: 26px; margin-bottom: 5px; }
        .stat-value { font-family: 'Fredoka One', cursive; font-size: 30px; color: #0f2c31; }
        .stat-label { font-size: 11px; font-weight: 800; color: #64748b; text-transform: uppercase; margin-top: 2px; }

        /* Two Column Layout */
        .columns-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .panel { padding: 22px; }

        /* Achievements List */
        .achievement-item { 
            background: #f8fafc; 
            border-radius: 12px; 
            padding: 12px; 
            display: flex; 
            align-items: center; 
            justify-content: space-between; 
            margin-bottom: 10px; 
            border: 1px solid #e2e8f0;
        }
        .achieve-info { display: flex; align-items: center; gap: 12px; }
        .achieve-icon { 
            width: 38px; 
            height: 38px; 
            background: #e6f4f1; 
            border-radius: 8px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 18px; 
        }
        .achieve-title { font-weight: 800; font-size: 14px; color: #0f2c31; }
        .achieve-desc { font-size: 11px; color: #64748b; }
        .check-icon { color: #20c997; font-weight: bold; font-size: 18px; }

        /* Recent Games Table */
        .games-table { width: 100%; border-collapse: collapse; margin-top: 5px; }
        .games-table th { 
            font-size: 11px; 
            color: #64748b; 
            text-align: left; 
            padding-bottom: 10px; 
            text-transform: uppercase; 
            border-bottom: 2px solid #e2e8f0;
        }
        .games-table td { 
            padding: 10px 0; 
            font-size: 13px; 
            font-weight: 700; 
            color: #2c3e50;
            border-top: 1px solid #f1f5f9; 
        }
        .score-plus { color: #20c997; font-weight: 800; text-align: right; }

        /* Info Data Rows */
        .info-row { 
            display: flex; 
            justify-content: space-between; 
            padding: 12px 0; 
            border-bottom: 1px solid #f1f5f9; 
            font-size: 13px; 
            font-weight: 700; 
        }
        .info-label { color: #64748b; text-transform: uppercase; font-size: 11px; }
        .info-val { color: #0f2c31; }

        /* Action Buttons */
        .action-bar { display: flex; justify-content: center; gap: 15px; margin-top: 15px; }
        .btn { 
            border: none; 
            padding: 12px 28px; 
            border-radius: 10px; 
            font-family: 'Fredoka One', cursive; 
            font-size: 14px; 
            cursor: pointer; 
            text-decoration: none; 
            text-transform: uppercase; 
            transition: all 0.2s ease; 
            display: inline-block;
        }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .btn-play { background: #20c997; color: #ffffff; }
        .btn-edit { background: #ffc107; color: #0f2c31; }
        .btn-logout { background: #ff4757; color: #ffffff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="top-navbar">
            <div style="font-size: 22px; font-weight: 800; color: #ffc107; font-family: 'Fredoka One', cursive;">
                Code <span style="color: #20c997;">Runner</span>
            </div>
            <div style="display: flex; align-items: center; gap: 12px;">
                <div style="background-color: rgba(255,255,255,0.15); color: #fff; padding: 6px 16px; border-radius: 20px; font-size: 14px; font-weight: 600;">
                    👾 <%= Session("Username") %>
                </div>
                <asp:Button ID="Button1" runat="server" Text="LOGOUT" OnClick="btnLogout_Click" Style="background-color: #ff4757; color: white; border: none; padding: 7px 18px; font-weight: bold; border-radius: 6px; cursor: pointer;" />
            </div>
        </header>

        <div class="container">
            <!-- Header Card -->
            <div class="profile-header">
                <div class="user-info">
                    <div class="avatar">👤</div>
                    <div>
                        <div class="username"><asp:Label ID="lblHeaderUsername" runat="server" Text="Player"></asp:Label></div>
                        <div class="subtitle">Code Runner Player</div>
                        <div class="badge-level">LEVEL <asp:Label ID="lblHeaderLevel" runat="server" Text="1"></asp:Label></div>
                    </div>
                </div>
                <div class="rank-box">
                    <div class="rank-title">Global Rank</div>
                    <div class="rank-num"># <asp:Label ID="lblGlobalRank" runat="server" Text="24"></asp:Label></div>
                </div>
            </div>

            <!-- XP Progress -->
            <div class="xp-card">
                <div class="xp-header">
                    <span>Experience Progress</span>
                    <span><asp:Label ID="lblCurrentXP" runat="server" Text="0"></asp:Label> / 1000 XP</span>
                </div>
                <div class="progress-bg">
                    <div class="progress-fill" id="divXpFill" runat="server" style="width: 0%;"></div>
                </div>
            </div>

            <!-- Player Stats Grid -->
            <div>
                <div class="section-title">Player Statistics</div>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">⭐</div>
                        <div class="stat-value"><asp:Label ID="lblStatTotalScore" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">👾</div>
                        <div class="stat-value"><asp:Label ID="lblStatGamesPlayed" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Games Played</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">🏆</div>
                        <div class="stat-value"><asp:Label ID="lblStatWins" runat="server" Text="1"></asp:Label></div>
                        <div class="stat-label">Wins</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">📈</div>
                        <div class="stat-value"><asp:Label ID="lblStatWinRate" runat="server" Text="2%"></asp:Label></div>
                        <div class="stat-label">Win Rate</div>
                    </div>
                </div>
            </div>

            <!-- Columns Section -->
            <div class="columns-grid">
                
                <!-- Achievements Panel -->
                <div class="panel">
                    <div class="panel-title">Achievements</div>
                    <div class="achievement-item">
                        <div class="achieve-info">
                            <div class="achieve-icon">🏆</div>
                            <div>
                                <div class="achieve-title">Code Master</div>
                                <div class="achieve-desc">Complete 25 successful runs</div>
                            </div>
                        </div>
                        <div class="check-icon">✓</div>
                    </div>
                    <div class="achievement-item">
                        <div class="achieve-info">
                            <div class="achieve-icon">⚡</div>
                            <div>
                                <div class="achieve-title">Speed Runner</div>
                                <div class="achieve-desc">Finish a level quickly</div>
                            </div>
                        </div>
                        <div class="check-icon">✓</div>
                    </div>
                    <div class="achievement-item">
                        <div class="achieve-info">
                            <div class="achieve-icon">💎</div>
                            <div>
                                <div class="achieve-title">High Scorer</div>
                                <div class="achieve-desc">Score more than 2000 points</div>
                            </div>
                        </div>
                        <div class="check-icon">✓</div>
                    </div>
                    <div class="achievement-item">
                        <div class="achieve-info">
                            <div class="achieve-icon">🔥</div>
                            <div>
                                <div class="achieve-title">Perfect Run</div>
                                <div class="achieve-desc">Complete a run without losing a life</div>
                            </div>
                        </div>
                        <div class="check-icon">✓</div>
                    </div>
                </div>

                <!-- Recent Games Panel -->
                <div class="panel">
                    <div class="panel-title">Recent Games</div>
                    <table class="games-table">
                        <thead>
                            <tr>
                                <th>Level</th>
                                <th>Date</th>
                                <th style="text-align:right;">Score</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptRecentGames" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>LEVEL <%# Eval("level") %></td>
                                        <td><%# Eval("dateString") %></td>
                                        <td class="score-plus">+<%# Eval("gameScore") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <!-- Player Information Panel -->
                <div class="panel">
                    <div class="panel-title">Player Information</div>
                    <div class="info-row">
                        <span class="info-label">Player Name</span>
                        <span class="info-val"><asp:Label ID="lblInfoName" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Player ID</span>
                        <span class="info-val"><asp:Label ID="lblInfoID" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Current Level</span>
                        <span class="info-val"><asp:Label ID="lblInfoLevel" runat="server" Text="1"></asp:Label></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Highest Score</span>
                        <span class="info-val"><asp:Label ID="lblInfoHighScore" runat="server" Text="0"></asp:Label></span>
                    </div>
                </div>

                <!-- Best Performance Panel -->
                <div class="panel">
                    <div class="panel-title">Best Performance</div>
                    <div class="info-row">
                        <span class="info-label">Best Level</span>
                        <span class="info-val">LEVEL <asp:Label ID="lblBestLevel" runat="server" Text="1"></asp:Label></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Highest Score</span>
                        <span class="info-val"><asp:Label ID="lblPerfHighScore" runat="server" Text="0"></asp:Label> POINTS</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Best Streak</span>
                        <span class="info-val"><asp:Label ID="lblBestStreak" runat="server" Text="3"></asp:Label> WINS</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Codes Collected</span>
                        <span class="info-val"><asp:Label ID="lblCodesCollected" runat="server" Text="0"></asp:Label></span>
                    </div>
                </div>

            </div>

            <!-- Action Buttons -->
            <div class="action-bar">
                <asp:Button ID="btnplay" runat="server" Text="Play Game" CssClass="btn btn-play" OnClick="btnplay_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-logout" OnClick="btnLogout_Click" />
            </div>

        </div>
    </form>
</body>
</html>