Imports System
Imports System.Collections.Generic
Imports System.Web.Script.Serialization

Namespace LevelPage

    Partial Class Levels
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            lblUsername.Text = Session("Username").ToString()

            'User must be logged in
            If Session("Username") Is Nothing Then
                Response.Redirect("~/Account/Login.aspx")
                Exit Sub
            End If

        End Sub


        '========================================================
        ' LEVEL 1
        ' Sum of Three Numbers
        '========================================================
        Protected Sub Level1_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(1)
        End Sub


        '========================================================
        ' LEVEL 2
        ' Greatest of Three Numbers
        '========================================================
        Protected Sub Level2_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(2)
        End Sub


        '========================================================
        ' LEVEL 3
        ' Odd or Even
        '========================================================
        Protected Sub Level3_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(3)
        End Sub


        '========================================================
        ' LEVEL 4
        ' Positive or Negative
        '========================================================
        Protected Sub Level4_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(4)
        End Sub


        '========================================================
        ' LEVEL 5
        ' Palindrome
        '========================================================
        Protected Sub Level5_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(5)
        End Sub


        '========================================================
        ' LEVEL 6
        ' Square Root and Cube Root
        '========================================================
        Protected Sub Level6_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(6)
        End Sub


        '========================================================
        ' LEVEL 7
        ' Simple Interest
        '========================================================
        Protected Sub Level7_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(7)
        End Sub


        '========================================================
        ' LEVEL 8
        ' Student Percentage and Total
        '========================================================
        Protected Sub Level8_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(8)
        End Sub


        '========================================================
        ' LEVEL 9
        ' Calculator Using Functions
        '========================================================
        Protected Sub Level9_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(9)
        End Sub


        '========================================================
        ' LEVEL 10
        ' Employee Salary Using Class and Objects
        '========================================================
        Protected Sub Level10_Click(ByVal sender As Object, ByVal e As EventArgs)
            StartLevel(10)
        End Sub


        '========================================================
        ' START SELECTED LEVEL
        '========================================================
        Private Sub StartLevel(ByVal level As Integer)

            Session("CurrentLevel") = level

            Dim tokens As List(Of String) = GetLevelTokens(level)

            Dim serializer As New JavaScriptSerializer()

            Session("LevelTokensJson") = serializer.Serialize(tokens)


            Session("CollectedTokens") = New List(Of String)()


            Response.Redirect("~/GamePage/Game.aspx?level=" &
                level.ToString(),
                False
            )


            HttpContext.Current.ApplicationInstance.CompleteRequest()

        End Sub


        '========================================================
        ' GET TOKENS FOR EACH LEVEL
        '========================================================
       Private Function GetLevelTokens(
     ByVal level As Integer
 ) As List(Of String)

            Dim tokens As New List(Of String)()


            Select Case level

                Case 1

                    tokens.Add("a")
                    tokens.Add("=")
                    tokens.Add("10")
                    tokens.Add("b")
                    tokens.Add("=")
                    tokens.Add("20")
                    tokens.Add("c")
                    tokens.Add("=")
                    tokens.Add("30")
                    tokens.Add("total")
                    tokens.Add("=")
                    tokens.Add("a")
                    tokens.Add("+")
                    tokens.Add("b")
                    tokens.Add("+")
                    tokens.Add("c")
                    tokens.Add("print")


                Case 2

                    tokens.Add("a")
                    tokens.Add("=")
                    tokens.Add("10")
                    tokens.Add("b")
                    tokens.Add("=")
                    tokens.Add("25")
                    tokens.Add("c")
                    tokens.Add("=")
                    tokens.Add("15")
                    tokens.Add("greatest")
                    tokens.Add("=")
                    tokens.Add("a")
                    tokens.Add("if")
                    tokens.Add("b")
                    tokens.Add(">")
                    tokens.Add("greatest")
                    tokens.Add("greatest")
                    tokens.Add("=")
                    tokens.Add("b")
                    tokens.Add("if")
                    tokens.Add("c")
                    tokens.Add(">")
                    tokens.Add("greatest")


                Case 3

                    tokens.Add("number")
                    tokens.Add("=")
                    tokens.Add("15")
                    tokens.Add("if")
                    tokens.Add("number")
                    tokens.Add("%")
                    tokens.Add("2")
                    tokens.Add("==")
                    tokens.Add("0")
                    tokens.Add("print")
                    tokens.Add("Even")
                    tokens.Add("else")
                    tokens.Add("print")
                    tokens.Add("Odd")


                Case 4

                    tokens.Add("number")
                    tokens.Add("=")
                    tokens.Add("-10")
                    tokens.Add("if")
                    tokens.Add("number")
                    tokens.Add(">")
                    tokens.Add("0")
                    tokens.Add("print")
                    tokens.Add("Positive")
                    tokens.Add("elif")
                    tokens.Add("number")
                    tokens.Add("<")
                    tokens.Add("0")
                    tokens.Add("print")
                    tokens.Add("Negative")


                Case 5

                    tokens.Add("text")
                    tokens.Add("=")
                    tokens.Add("madam")
                    tokens.Add("reverse")
                    tokens.Add("=")
                    tokens.Add("text[::-1]")
                    tokens.Add("if")
                    tokens.Add("text")
                    tokens.Add("==")
                    tokens.Add("reverse")
                    tokens.Add("print")
                    tokens.Add("Palindrome")


                Case 6

                    tokens.Add("import")
                    tokens.Add("math")
                    tokens.Add("number")
                    tokens.Add("=")
                    tokens.Add("64")
                    tokens.Add("square_root")
                    tokens.Add("=")
                    tokens.Add("math.sqrt")
                    tokens.Add("number")
                    tokens.Add("cube_root")
                    tokens.Add("=")
                    tokens.Add("number")
                    tokens.Add("**")
                    tokens.Add("1/3")


                Case 7

                    tokens.Add("principal")
                    tokens.Add("=")
                    tokens.Add("10000")
                    tokens.Add("rate")
                    tokens.Add("=")
                    tokens.Add("5")
                    tokens.Add("time")
                    tokens.Add("=")
                    tokens.Add("2")
                    tokens.Add("interest")
                    tokens.Add("=")
                    tokens.Add("principal")
                    tokens.Add("*")
                    tokens.Add("rate")
                    tokens.Add("*")
                    tokens.Add("time")
                    tokens.Add("/")
                    tokens.Add("100")


                Case 8

                    tokens.Add("mark1")
                    tokens.Add("=")
                    tokens.Add("80")
                    tokens.Add("mark2")
                    tokens.Add("=")
                    tokens.Add("75")
                    tokens.Add("mark3")
                    tokens.Add("=")
                    tokens.Add("90")
                    tokens.Add("total")
                    tokens.Add("=")
                    tokens.Add("mark1")
                    tokens.Add("+")
                    tokens.Add("mark2")
                    tokens.Add("+")
                    tokens.Add("mark3")
                    tokens.Add("percentage")
                    tokens.Add("=")
                    tokens.Add("total")
                    tokens.Add("/")
                    tokens.Add("3")


                Case 9

                    tokens.Add("def")
                    tokens.Add("add")
                    tokens.Add("return")
                    tokens.Add("a")
                    tokens.Add("+")
                    tokens.Add("b")
                    tokens.Add("def")
                    tokens.Add("subtract")
                    tokens.Add("return")
                    tokens.Add("a")
                    tokens.Add("-")
                    tokens.Add("b")
                    tokens.Add("def")
                    tokens.Add("multiply")
                    tokens.Add("return")
                    tokens.Add("a")
                    tokens.Add("*")
                    tokens.Add("b")
                    tokens.Add("def")
                    tokens.Add("divide")
                    tokens.Add("return")
                    tokens.Add("a")
                    tokens.Add("/")
                    tokens.Add("b")


                Case 10

                    tokens.Add("class")
                    tokens.Add("Employee")
                    tokens.Add("def")
                    tokens.Add("__init__")
                    tokens.Add("self")
                    tokens.Add("name")
                    tokens.Add("salary")
                    tokens.Add("self.name")
                    tokens.Add("=")
                    tokens.Add("name")
                    tokens.Add("self.salary")
                    tokens.Add("=")
                    tokens.Add("salary")
                    tokens.Add("def")
                    tokens.Add("calculate_bonus")
                    tokens.Add("return")
                    tokens.Add("self.salary")
                    tokens.Add("*")
                    tokens.Add("0.10")


            End Select


            Return tokens

        End Function

    End Class

End Namespace