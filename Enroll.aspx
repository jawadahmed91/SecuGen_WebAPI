<%@ Page Title="Secugen-Enroll" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Enroll.aspx.cs" Inherits="Enroll" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Enroll</title>
</head>
<body>
  <div class="row">
    <h3><b>Demonstration of JavaScript access to SecuGen Fingerprint device.</b></h3>
    <div class="col-md-10">
	    <b>Captures 1 to 10 fingerprints, checks for duplicates and returns JSON object containing ISO template for each fingerprint and respective NFIQ value.  A lower NFIQ score indicates a higher fingerprint image quality.</b>
	    <center>
	            <table>
	                <tr>
		                <td>
			                <img id="LEFT_THUMB" border="1"  onclick="captureFP(0)" alt="LEFT_THUMB" height=200 width=150 src=".\images\hands\left_hand_6.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_LEFT_THUMB" onclick="captureFP(0)"></input> </Center> 
		                </td>
		                <td>
			                <img id="LEFT_INDEX" border="1" alt="LEFT_INDEX" height=200 width=150 src=".\images\hands\left_hand_7.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_LEFT_INDEX" onclick="captureFP(1)"></input> </Center>
		                </td>
		                <td>
			                <img id="LEFT_MIDDLE" border="1" alt="LEFT_MIDDLE" height=200 width=150 src=".\images\hands\left_hand_8.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_LEFT_MIDDLE" onclick="captureFP(2)"></input> </Center>
		                </td>
		                <td>
			                <img id="LEFT_RING" border="1" alt="LEFT_RING" height=200 width=150 src=".\images\hands\left_hand_9.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_LEFT_RING" onclick="captureFP(3)"></input> </Center>
		                </td>
		                <td>
			                <img id="LEFT_LITTLE" border="1" alt="LEFT_LITTLE" height=200 width=150 src=".\images\hands\left_hand_10.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_LEFT_LITTLE" onclick="captureFP(4)"></input> </Center>
		                </td>
	                </tr>
	                <tr>
		                <td> 	
			                <p id="LEFT_THUMB_INFO"> </p> 
		                </td>
		                <td> 
			                <p id="LEFT_INDEX_INFO"> </p>
		                </td>
		                <td> 
			                <p id="LEFT_MIDDLE_INFO"> </p>
		                </td>
		                <td> 
			                <p id="LEFT_RING_INFO"> </p>
		                </td>
		                <td> 
			                <p id="LEFT_LITTLE_INFO"> </p>
		                </td>
	                </tr>
	                <tr>
		                <td>
			                <img id="RIGHT_THUMB" border="1"  alt="RIGHT_THUMB" height=200 width=150 src=".\images\hands\right_hand_1.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_RIGHT_THUMB" onclick="captureFP(5)"></input> </Center>
		                </td>
		                <td>
			                <img id="RIGHT_INDEX" border="1" alt="RIGHT_INDEX" height=200 width=150 src=".\images\hands\right_hand_2.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_RIGHT_INDEX" onclick="captureFP(6)"></input> </Center>
		                </td>
		                <td>
			                <img id="RIGHT_MIDDLE" border="1" alt="RIGHT_MIDDLE" height=200 width=150 src=".\images\hands\right_hand_3.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_RIGHT_MIDDLE" onclick="captureFP(7)"></input> </Center>
		                </td>
		                <td>
			                <img id="RIGHT_RING" border="1" alt="RIGHT_RING" height=200 width=150 src=".\images\hands\right_hand_4.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_RIGHT_RING" onclick="captureFP(8)"></input> </Center>
		                </td>
		                <td>
			                <img id="RIGHT_LITTLE" border="1" alt="RIGHT_LITTLE" height=200 width=150 src=".\images\hands\right_hand_5.png" > <br>
			                <Center> <input type="button" value="Scan" id="BTN_RIGHT_LITTLE" onclick="captureFP(9)"></input> </Center>
		                </td>
	                </tr>
	                <tr>
		                <td> 
			                <p id="RIGHT_THUMB_INFO"> </p>
		                </td>
		                <td> 
			                <p id="RIGHT_INDEX_INFO"> </p>
		                </td>
		                <td> 
			                <p id="RIGHT_MIDDLE_INFO"> </p>
		                </td>
		                <td> 
			                <p id="RIGHT_RING_INFO"> </p>
		                </td>
		                <td> 
			                <p id="RIGHT_LITTLE_INFO"> </p>
		                </td>
	                </tr>
	            </table>
	            <div id="footer">
                    <input type="button" value="Show Data" id="BTN_SHOW_DATA" onclick="showResult()"></input>  
		            <input type="button" value="Restart/New" id="BTN_RESTART" onclick="Restart()"></input><br>
		            <p class="small" id="timetaken"> </p> 
	            </div>
	            </br>
	    </Center>
    </div>
  </div>
</body>
<script type="text/javascript">

	var	fingerpos = ["LEFT_THUMB", "LEFT_INDEX", "LEFT_MIDDLE", "LEFT_RING", "LEFT_LITTLE",
				"RIGHT_THUMB", "RIGHT_INDEX", "RIGHT_MIDDLE", "RIGHT_RING", "RIGHT_LITTLE" ];
	var	service_handle = "";
	var	ENROLL_OBJ; 
	var cdate = new Date();
	var TotalEnrollments = 0;


	function Restart()
	{
	    TotalEnrollments = 0;
		location.reload(true);
	}
	function showResult()
	{
	    var i = 0;
		var result = "";
		if (ENROLL_OBJ)
		{
		    for (i = 0; i < TotalEnrollments; i++)
		    {
		        result += i + ".  " + ENROLL_OBJ.EnrollData.Templates[i].fpos + "; NFIQ[";
		        result += ENROLL_OBJ.EnrollData.Templates[i].nfiq + "]; TemplateBase64 [\n";
		        result += ENROLL_OBJ.EnrollData.Templates[i].TemplateBase64 + "]\n";
		    }
			alert(result);
		}
	}
	function UpdateDuration()
	{
		ndate = new Date();
		var duration = Math.abs(ndate - cdate );
		var mins =	Math.floor(duration / 1000 / 60);
		duration = duration - (mins * 60 * 1000);
		var secs =	Math.floor(duration / 1000) ;
		duration = duration / 1000;
		document.getElementById("timetaken").innerHTML = "Time Taken " +  mins + " Mins " + secs + " Seconds";
	}
	function captureFP( arridx ) 
	{
		var	imgid = fingerpos[arridx];
		if ( ENROLL_OBJ && ENROLL_OBJ.length > arridx  && ENROLL_OBJ.EnrollData[arridx].na >= 3 )
		{
			alert("Maximum Attempts Over!");
			return;
		}
		document.getElementById(imgid).src = ".\Images\wait.gif";
		CallSGIFPGetData( arridx,  SuccessFunc, ErrorFunc);
	}
	/* 
		This functions is called if the service sucessfully returns some data in JSON object
		Always check for ErrorCode 
	 */
	function	SuccessFunc( arridx, fpdata )
	{
		var	imgid = fingerpos[arridx];
		var	val  = imgid + "_INFO";
		if ( fpdata.ErrorCode == 0 )
		{
			if ( service_handle != "" && fpdata.SerHandle != service_handle )
			{
				alert("Session Timeout you will need to restart");
				Restart();
				return;
			}
			service_handle = fpdata.SerHandle;
			if ( fpdata.Result == 2 )
			{
				alert("Duplicate Finger!");
			}
			else if ( fpdata.Result == 1 )
			{
				alert("Higher or same NFIQ than earlier rejecting");
				document.getElementById(val).innerHTML = "Attempts = " + fpdata.Attempts + 
					" NFIQ = " + fpdata.NFIQ;
			}
			/*
				Successful execuation gets the JSON object with all the templates  currently scanned
			*/
			else if ( fpdata.Result == 0 )
			{
				if ( fpdata.BMPBase64.length > 0   )
				{
					document.getElementById(imgid).src = "data:image/bmp;base64," + fpdata.BMPBase64;
				}
				document.getElementById(val).innerHTML = "Attempts = " + fpdata.Attempts + 
					" NFIQ = " + fpdata.NFIQ;
			}
			if ( fpdata.Attempts >= 3 || fpdata.NFIQ == 1 )
			{
				var btnid = "BTN_" + imgid;
				document.getElementById(btnid).disabled = true;
			}
		}
		else 
		{
		    TotalEnrollments--;
		    alert("Fingerprint Capture Error Code:  " + fpdata.ErrorCode + ".\nDescription:  " + ErrorCodeToString(fpdata.ErrorCode) + ".");
		}
		UpdateDuration();
	}

	function	ErrorFunc ( status )
	{
		
		/* 	
			If you reach here, user is probabaly not running the 
			service. Redirect the user to a page where he can download the
			executable and install it. 
		*/

	    alert("Check if SGIBIOSRV is running; If NOT installed, then install at top of page; status = " + status + ":");
	}
	function	CallSGIFPGetData( arridx, successCall, failCall )
	{
		var	sgifpdata;
		var	uri 	= "https://localhost:8443/SGIFPEnroll";
		var	params 	= "timeout=" + "10000";
	       		params  += "&quality=" + "40";
	       		params  += "&srvhandle=" + service_handle;
	       		params  += "&FingerPos=" + fingerpos[arridx];

			
		var	xmlhttp = new XMLHttpRequest();
		xmlhttp.open("POST", uri, true );
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
			    TotalEnrollments++;
				fpobject = JSON.parse(xmlhttp.responseText);
				ENROLL_OBJ = fpobject;
				successCall( arridx, fpobject);
			}
			else if ( xmlhttp.status == 404 )
			{
				failCall(xmlhttp.status)
			}
		}
		xmlhttp.onerror=function()
		{
			failCall(xmlhttp.status);
		}
		xmlhttp.send(params);
	}

</script>
</html>
</asp:Content>
