<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 23.05.2017
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en"> <!--<![endif]-->
<style>
    <%@include file="/pages/css/loginStyle.css" %>
    <%@include file="/pages/css/demo.css" %>
</style>
<head>
    <meta charset="UTF-8"/>
    <title>Вход</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <header>
        <script type="text/javascript">
            function validate_register_form() {

                var valid = true;
                var massage = null;
                var reg = "[$%!#'/\\\"]";
                var password;
                if ((text = document.getElementById("userLogin").value) != "") {
                    if (text.match(reg) != null) {
                        massage = "Field 'login' can not have next characters $%!#'/\\\"";
                        valid = false;
                    }
                }
                else {
                    massage = "Please, input correct date to 'login' field.";
                    valid = false;
                }
                if ((text = document.getElementById("userName").value) != "") {
                    if (text.match(reg) != null) {
                        massage = "Field 'name and last name' can not have next characters $%!#'/\\\"";
                        valid = false;
                    }
                }
                else {
                    massage = "Please, input correct date to 'first and last name' field.";
                    valid = false;
                }
                if ((text = document.getElementById("email").value) != "") {
                    if (text.match(reg) != null) {
                        massage = "Field 'e-mail' can not have next characters $%!#'/\\\"";
                        valid = false;
                    }
                    if (text.match("@") == null) {
                        massage = "Invalid e-mail!";
                        valid = false;
                    }
                } else {
                    massage = "Please, input correct date to 'e-mail' field.";
                    valid = false;
                }
                if ((text = document.getElementById("password").value) != "") {
                    if (text.match(reg) != null) {
                        massage = "Field 'password' can not have next characters $%!#'/\\\"";
                        valid = false;
                    }
                    else {
                        password = text;
                    }
                }
                else {
                    massage = "Please, input correct date to 'password' field.";
                    valid = false;
                }
                if ((text = document.getElementById("password_confirm").value) != "") {
                    if (text.match(reg) != null) {
                        massage = "Field 'password confirm' can not have next characters $%!#'/\\\"";
                        valid = false;
                    }
                    else {
                        if (password != text) {
                            valid = false;
                            massage = "Passwords do not match!";
                        }
                    }
                }
                else {
                    massage = "Please, input correct date to 'password' field.";
                    valid = false;
                }
                $("#massage").text(massage);
                return valid;
            }
        </script>
    </header>
    <section>
        <div id="container_demo">
            <div id="wrapper">
                <div id="register">
                    <form action="controller" method="post" onsubmit="return validate_register_form();">


                        <c:set var="massage" value="${requestScope.massage}"></c:set>
                        <c:set var="login" value="${requestScope.login}"></c:set>
                        <c:set var="name" value="${requestScope.name}"></c:set>
                        <c:set var="email" value="${requestScope.email}"></c:set>




                        <h1> Sign up </h1>
                        <p>
                            <label for="userLogin" class="uname">Your login</label>
                            <input id="userLogin" name="login" type="text" value="${login}" placeholder="login"/>
                        </p>
                        <p>
                            <label for="userName" class="uname">Your first and last name</label>
                            <input id="userName" name="name" type="text" value="${name}" placeholder="Ivan Ivanov"/>
                        </p>
                        <p>
                            <label for="email" class="youmail"> Your e-mail</label>
                            <input id="email" name="email" type="text"  value="${email}" placeholder="ivan@gmail.com"/>
                        </p>
                        <p>
                            <label for="password" class="youpasswd">Your password</label>
                            <input id="password" name="password" type="password"
                                   placeholder="eg. X8df!90EO"/>
                        </p>
                        <p>
                            <label for="password_confirm" class="youpasswd">Please, confirm your password</label>
                            <input id="password_confirm" name="passwords_confirm" type="password"
                                   placeholder="eg. X8df!90EO"/>
                        </p>
                        <label id="massage" class="uname">${massage}</label>
                        <input type="hidden" name="command" value="registration">
                        <p class="signin button">
                            <input type="submit" value="Sign up" name="registration"/>
                        </p>
                        <p class="change_link">
                            Already a member ?
                            <a href="/controller?command=registration&goLogin=true" class="to_register"> Go and log
                                in </a>
                        </p>
                    </form>
                </div>

            </div>
        </div>
    </section>
</div>
</body>
</html>
