<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "">
<#include "navigation.ftl">
<#include "banner.ftl">
<main role="main">
    <div>

        <h1>Renjin Enterprise Support</h1>

        <p> Renjin Enterprise Support (RES) is an annual subscription-based
            product that gives you access to Renjin source and binaries,
            proprietary add-on modules, and access to professional services from
            the team behind Renjin.</p>

        <p>For organizations who rely on Renjin to support mission-critical
            applications, RES provides rapid issue response, phone and support
            portal access, and assistance directly from our engineers and developers.</p>

        <h2>Overview</h2>


        <table class="comparison">
            <thead>
            <tr>
                <th></th>
                <th>Community</th>
                <th>Renjin Enterprise Support</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <th colspan="3">Software</th>
                </tr>
                <tr>
                    <th><a href="#nightly">Renjin Nightly Builds</a></th>
                    <td>Yes</td>
                    <td>Yes</td>
                </tr>
                <tr>
                    <th><a href="#certified">Renjin Certified Releases</a></th>
                    <td>-</td>
                    <td>Yes</td>
                </tr>
                <tr>
                    <th><a href="#backporting">Backporting of bug fixes for major releases for up to 3 years</a></th>
                    <td>-</td>
                    <td>Yes</td>
                </tr>
                <tr>
                    <th><a href="#java-support">Supported Java Runtimes</a></th>
                    <td>Java 8+</td>
                    <td>Java 6+</td>
                </tr>
                <tr>
                    <th colspan="3">Services</th>
                </tr>
                <tr>
                    <th><a href="#priority">Priority Support</a></th>
                    <td>-</td>
                    <td>Yes</td>
                </tr>
                <tr>
                    <th><a href="#critical">Critical defect resolution</a></th>
                    <td>-</td>
                    <td>48hrs</td>
                </tr>
                <tr>
                    <th><a href="#pricing">Pricing</a></th>
                    <td>Free</td>
                    <td>€4800/developer/year</td>
                </tr>
            </tbody>
        </table>

        <h2 id="nightly">Nightly builds</h2>

        <p>BeDataDriven provides nightly builds of Renjin, and all CRAN and BioConductor packages as a free,
        public service. These builds pass all of Renjin's 30,000+ unit tests, but may include new features
        or experimental improvements that carry the risk of performance or compatibility regressions.</p>

        <h2 id="certified">Renjin Certified Releases</h2>

        <p>With a commercial support subscription, you receive access to Renjin Certified Releases.
            Certified Releases are built from the same source as our publicly-available releases, and
            also licensed under the GPLv2, but have a release schedule designed to provide enterprises
            with the stability and confidence needed for mission-critical applications.</p>

        <p>Renjin Certified Releases are tested against all CRAN and BioConductor packages, and only include
        new features or optimizations which have been piloted in real-world scenarios.</p>

        <h2 id="backporting">Backporting of bug fixes for major releases</h2>

        <p>Renjin Certified Releases also receive bug fixes for up to three years after their initial release.
        This ensures that long-running applications can </p>

        <h2 id="java-support">Long-term Java Support</h2>

        <p>Our freely-available nightly builds target Java 8 or higher. Renjin Enterprise Subscribers also get
        access to certified releases that are compatible with Java 6 or Java 7. These releases may not offer the
        same performance as Renjin running on the latest JVM, but they provide a solution for highly constrained
        environments, for example Oracle 11g, which only supports Java 6.</p>

        <h2 id="priority">Priority support</h2>

        <p>The Support Desk allows named Technical Contacts to get private help directly from BeDataDriven
            engineers, either for defect resolution or general help with Renjin.</p>

        <h2 id="critical">Critical defect resolution</h2>

        <p>For the purposes of our commercial support, we consider there to be a defect when a Renjin
            Certified Release produces a different result than the corresponding version of GNU R, using only “pure R”.</p>

        <p>Defects can be reported to our support desk and must include a reproducible test script to be covered by
            Service Level Agreement (SLA) that commits us to providing a hotfix or workaround within 48 hours.
            Code that relies on third party packages are excluded from this SLA.
        </p>

        <h2 id="pricing">Pricing</h2>

        <p>Our pricing for the Renjin Enterprise Subscription is based on the number of developers who are entitled
            to direct support from BeDataDriven. </p>

    </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
