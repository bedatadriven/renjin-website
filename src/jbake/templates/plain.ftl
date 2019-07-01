<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "">
<#include "navigation.ftl">
<#include "banner.ftl">
<main role="main">
    <div>

        <h1>${content.title}</h1>

        ${content.body}

    </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
