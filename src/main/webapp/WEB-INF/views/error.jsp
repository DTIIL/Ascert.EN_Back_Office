
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        body {
            margin: 0;
            padding: 0 20px;
            color: #001332;
            font-family: "IBM Plex Sans", Arial, sans-serif;
            background: #f4f7fb;
        }

        body > div {
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding: 32px 28px;
            background: #fff;
            border: 1px solid #e6ebf2;
            border-radius: 14px;
            box-shadow: 0 1px 2px rgba(15,23,42,.04), 0 8px 24px rgba(15,23,42,.04);
        }

        h1 {
            margin: 0 0 10px;
            font-size: 22px;
            font-weight: 650;
            letter-spacing: -.02em;
        }

        p {
            margin: 0 0 22px;
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
        }

        a {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 9px;
            background: #005df8;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        a:hover {
            background: #004dcc;
        }
    </style>
</head>
<body>

<div style="text-align: center; margin-top: 100px;">

    <h1>Something went wrong!</h1>

    <p>
        Something went wrong while processing your request.
        Please try again later.
    </p>

    <a href="${pageContext.request.contextPath}/dashboard">
        Back to Dashboard
    </a>

</div>

</body>
</html>
