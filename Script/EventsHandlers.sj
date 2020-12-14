//USEUNIT SciexScript

//***************************************************************************************************************
//Name          -     EventControl1_OnLogError
//Description   -     Function will execute when error occures and takes error picture
//Parameters    -     Sender, LogParams
//Return type   -     None   
//***************************************************************************************************************
function EventControl1_OnLogError(Sender, LogParams)
{
  Log.Message("Error Occured");
  var ErrorPic = Sys.Desktop.Picture();
  Log.Picture(ErrorPic, "Error Image");
}

//***************************************************************************************************************
//Name          -     EventControl1_OnOverlappingWindow
//Description   -     Function will execute window overlaps and takes error picture
//Parameters    -     Sender, Window, OverlappingWindow, LogParams
//Return type   -     None   
//***************************************************************************************************************
function EventControl1_OnOverlappingWindow(Sender, Window, OverlappingWindow, LogParams)
{
  Log.Message("OverlappingWindow Occured");
  var OverlappingWindowrPic = Sys.Desktop.Picture();
  Log.Picture(OverlappingWindowrPic, "OverlappingWindowr Image");
}

//***************************************************************************************************************
//Name          -     EventControl1_OnUnexpectedWindow
//Description   -     Funcrtion will execute when Unexpected Window Opened and display the Picture
//Parameters    -     Sender, Window, LogParams
//Return type   -     None   
//***************************************************************************************************************
function EventControl1_OnUnexpectedWindow(Sender, Window, LogParams)
{
  Log.Message("UnexpectedWindow Opened");
  var UnexpectedWindowPic = Sys.Desktop.Picture();
  Log.Picture(UnexpectedWindowPic, "UnexpectedWindow Image");
}

//***************************************************************************************************************
//Name          -     EventControl1_OnStopTest
//Description   -     This Function will always call at the end of the script execution and it will convert log file into MHT file 
//Parameters    -     Sender
//Return type   -     None   
//***************************************************************************************************************
function EventControl1_OnStopTest(Sender)
{
  
  TestedApps.SciexOs.Close()
  Log.Checkpoint("Sciex OS Application is Closed...")
  Log.SaveResultsAs("C:\\Work\\Log_"+aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m_%d_%Y_%H_%M_%S")+".mht", lsMHT);
  
  TestedApps.calc.Close();
}

//***************************************************************************************************************
//Name          -     EventControl1_OnStartTest
//Description   -     Executed before running the script and closes the application if already exist                
//Parameters    -     Sender
//Return type   -     None   
//***************************************************************************************************************
function EventControl1_OnStartTest(Sender)
{ 
  app = Sys.WaitProcess("SciexOs")
  if(app.Exists){
    Log.Checkpoint("Sciex OS Application already exist, Closing and Re-launching..")
    app.Close();
  }
  else{
    Log.Message("Sciex OS Application Does not exist")
  }
  
  app2 = Sys.WaitProcess("calc")
  if(app2.Exists){
    Log.Checkpoint("Calculator Application already exist, Closing and Re-launching..")
    app2.Close();
  }
  else{
    Log.Message("Calculator Application Does not exist")
  }
}