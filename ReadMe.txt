
SecuGen Web API

version:  1.0.0.54


1:59 PM 12/14/2018
1.  Bugs were introduced with first code drop of SgiBioSrv, v1.0.0.41, this build fixes those.
2.  Compile warnings for sgibiosrv were not resolved, as future code drops will re-introduce those.
3.  SgiBioSrv did have SgFpLib.dll upgraded to keep the larger device support.


SecuGen Web API

version:  1.0.0.51
1:59 PM 11/05/2018
1.  Got SgiBioSrv source code drop from 8/30/18 from Roy.
2.  Build script does all steps of build from assembling the host web site, compiling the SgiBioSrv's, all 4, to then building single zip file to publish for sales and Azure host web site for Secugen demo's.
3.  Additional device support of U20A, U20AP, and U10AP.

SecuGen Web API

version:  1.0.0.40


1:50 PM 3/28/2018


List of current Issues:

1.  Opera browser is also currently not supported
- Opera 47.0.2631.55

2.  
List of known supported browsers:

- Google Chrome v65.0.3325.181 (64-bit)

- Microsoft Internet Explorer 11.540.15063.0

- Microsoft Edge 40.15063.0.0
- Firefox Quantum v60.0b7 (64-bit)

- Firefox Developer Edition v60.0b7 (64-bit)

For Firefox browser support, the SCI.com Certificate must be installed in the browser.


1.  Once Firefox browser is up, click the "Open Menu" button on right hand side.  This is the 3 horizontal bars button.

2.  Select Options.
3.  On the left hand side, click on Privacy & Security.

4.  On the bottom of the web page, click "View Certificates".

5.  Click on the Authorities Tab.

6.  Click on the Import button.
7.  Navigate to the application directory.  Usually "C:\Program Files\SecuGen\SgiBioSrv" or "C:\Program Files (x86)\SecuGen\SgiBioSrv".  Click on Sgica.crt.

Restart browser.



