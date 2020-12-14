﻿//USEUNIT AllVariables 

//***********************************************************************************************************************************
//Name          -     LaunchSciexOS
//Description   -     Function will launch the Sciex OS application and verify whether Sciex OS Application is Launched or not
//Parameters    -     None
//Return type   -     None   
//***********************************************************************************************************************************
function LaunchSciexOS()
{
  TestedApps.SciexOs.Run()
  if( Aliases.SciexOs.HwndSource_ShellView.Visible==true)
  {
   Log.Checkpoint("Sciex OS Application is Launched")
  }
  else
  Log.Warning("Sciex OS Application is NOT Launched")
  
}

//*********************************************************************************************************************************************
//Name          -     LaunchAnalyticsFromSciexOS
//Description   -     Function will launch the Analytics module of the application to verify whether Analytics Window is launched or not
//Parameters    -     None
//Return type   -     None   
//********************************************************************************************************************************************
function LaunchAnalyticsFromSciexOS()
{
  Analytic.Click()
  if(Aliases.SciexOs.HwndSource_ShellView.VisibleOnScreen ==true)
  {
   Log.Checkpoint("Analytics Window is Launched ")
  }
  else
  Log.Warning("Analytics Window is NOT Launched")
   
}

//***************************************************************************************************************
//Name          -     OpenResultTab
//Description   -     Function will open the Result tab and selects the New tab
//Parameters    -     Value
//Return type   -     None   
//***************************************************************************************************************
function OpenResultTab(Value)
{
  Results.Click()
  ResultItem = Aliases.SciexOs.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1)
  New = ResultItem.FindChild("WPFControlText",Value,5);
  New.Click()
}

//*************************************************************************************************************************
//Name          -     OpenFile
//Description   -     Function will selects the Mix_Batch file and to verify whether Method editor window is launched or not
//Parameters    -     None
//Return type   -     None   
//**************************************************************************************************************************
function OpenFile()
{
  Mix_Batch.Click()
  Arrow.Click()
  Process.Click()
  if( Aliases.SciexOs.WPFObject("HwndSource: MethodEditDialog", "[AutoPeak] Automatic Method").VisibleOnScreen ==true)
  {
    Log.Checkpoint("Method Editior window is Launched ")
  }
  else
    Log.Warning("Method Editior window is NOT Launched")
  ProcessAndClose.Click()
}

//*************************************************************************************************************************
//Name          -     ResultTabOperation
//Description   -     Function will process the file and to verify all data is loaded correctely into the application
//Parameters    -     None
//Return type   -     None   
//**************************************************************************************************************************
function ResultTabOperation()
{
  if((Aliases.SciexOs.HwndSource_ShellView.ShellView.WPFObject("RootGrid").WPFObject("OFXDefaultLayout", "", 1).WPFObject("Grid", "", 1).WPFObject("MainWindow").WPFObject("LeftWindow").WPFObject("WorkspaceWindow").WPFObject("PrimaryRegion").WPFObject("ComponentView", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TabbedHost").VisibleOnScreen==true))
  {
    Log.Message("Results Table is launched with Untitled (no title) ")
  }
  else
    Log.Warning("Results Table is  NOT launched ")
  ComponentsAndGroup.Click()
  AllComponents.Click()
  WaitForObject(AllComponents, 30)
  if(Aliases.SciexOs.HwndSource_ShellView.zultraGrid.wRowCount==196)
    Log.Checkpoint("Untitled Results Table is displayed with all the 196 rows")
  else
    Log.Warning("Untitled Results Table is displayed But 196 rows are not there")
}

//*************************************************************************************************************************
//Name          -     UpdateAndSaveResultTable
//Description   -     Function will make changes to the file data and verify the same and save the file into local machine
//Parameters    -     None
//Return type   -     None   
//**************************************************************************************************************************
function UpdateAndSaveResultTable()
{
  GridSelect.ClickCell(0, "Sample Name")
  TextRename.Click()
  TextRename.SetText("STD 1_New")
  TextRename.Keys("[Tab]")
  value = Aliases.SciexOs.HwndSource_ShellView.zultraGrid
  if(value.wValue(0, 1)=="STD 1_New" && value.wValue(1, 1)=="STD 1_New" && value.wValue(2, 1)=="STD 1_New" && value.wValue(3, 1)=="STD 1_New")
    Log.Checkpoint("STD1 is changes to STD1_New")
  else
    Log.Warning("STD1 is NOT changes to STD1_New")
  SampleTab.Click()
  ComponentsAndGroup.Click()
  AllComponents.Click()
  CommonFunctions.OpenResultTab("Save")
  ResultSelection.Click()
  Save.Click()
  AnalyticError.Click();
}

//******************************************************************************************************************************
//Name          -     OpenProcessMethodTab
//Description   -     Function will open Process Method tab and verify whether Automatic method window and Peak Review window is
//                    launched or not and Change of component name from "210.2/164.2" to "210.2/164.3" and verify the changes
//Parameters    -     None
//Return type   -     None   
//*******************************************************************************************************************************
function OpenProcessMethodTab()
{
  ProcessMethod.Click();
  ProcessItems =Aliases.SciexOs.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1)
  Edit = ProcessItems.FindChild("WPFControlText","Edit embedded method…",5);
  Edit.Click();
  WaitForObject(Edit, 30)
  if(Aliases.SciexOs.HwndSource_MethodModifyDialog.Visible ==true)
  {
    Log.Checkpoint("(Autopeak) Automatic method window is launched")
  }
  else
    Log.Warning("(Autopeak) Automatic method window is NOT launched")
  Component.Click()
  GridSelectComponent.ClickCell(0,"Name")
  TextRenameComponent.Click()
  TextRenameComponent.SetText("210.2 / 164.3");
  ProcessAndCloseComponent.Click()
  ComponentsAndGroup.Click()
  AllComponents.Click()
  if(Aliases.SciexOs.HwndSource_ShellView.zultraGrid.wValue(0, 3)== "210.2 / 164.3")
    Log.Checkpoint("Change of component name from 210.2/164.2 to 210.2/164.3 is observed.")
  else
    Log.Warning("No Change of component name from 210.2/164.2 to 210.2/164.3. ")
  PeakReview.Click()
  if(NameMapping.Sys.SciexOs.HwndSource_ShellView.WinFormsAdapter.Form2.PMControl.PMRowColControl.PMPane.PMRowColControl.PMPane.Visible ==true)
  {
    Log.Checkpoint("Peak Review window is opened")
  }
  else
    Log.Warning("Peak Review window is NOT opened")
}

//******************************************************************************************************************************
//Name          -     ViewTab
//Description   -     Function will open View tab and verify Both XIC and XIC Side by Side are present under View tab.
//                    and makes changes to ExpectedRT value and verify the same
//Parameters    -     None
//Return type   -     None   
//*******************************************************************************************************************************
function ViewTab()
{
  View.Click()
  ViewItems= Aliases.SciexOs.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1)
  Xic = ViewItems.FindChild("WPFControlText","XIC",3)
  if( Aliases.SciexOs.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "XIC", 3).Enabled && Aliases.SciexOs.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "XIC Side by Side", 4).Enabled
  == true)
  {
    Log.Checkpoint("Both XIC and XIC Side by Side are present under View tab. ")
  }
  else
    Log.Warning(" XIC and XIC Side by Side are NOT present under View tab.")
    
  Xic.Click()
  ExpectedRT.Click()
  ExpectedRT.Clear()
  ExpectedRT.Keys("2.50[Tab]");
  ApplyButton.Click()
  if(Aliases.SciexOs.HwndSource_ShellView.zultraGrid.wValue(0, 7)== 2.50)
    Log.Checkpoint("Expected RT value in row one is changed to 2.50. ")
  else
    Log.Warning("Expected RT value in row one is NOT changed to 2.50. ")
 }

//******************************************************************************************************************************
//Name          -     CloseAllTabs
//Description   -     Function will Closes all tabs one by one and verify the same.
//Parameters    -     None
//Return type   -     None   
//*******************************************************************************************************************************
function CloseAllTabs()
{
  PeakTabClose.Click()
  if(!(NameMapping.Sys.SciexOs.HwndSource_ShellView.WinFormsAdapter.Form2.PMControl.PMRowColControl.PMPane.PMRowColControl.PMPane.VisibleOnScreen.Exists))
    Log.Checkpoint("Peak Review window is Closed")
  else
    Log.Warning("Peak Review window is NOT Closed")

  ResultTabClose.Click()
  if(!(Aliases.SciexOs.HwndSource_ShellView.ShellView.WPFObject("RootGrid").WPFObject("OFXDefaultLayout", "", 1).WPFObject("Grid", "", 1).WPFObject("MainWindow").WPFObject("LeftWindow").WPFObject("WorkspaceWindow").WPFObject("PrimaryRegion").WPFObject("ComponentView", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TabbedHost").VisibleOnScreen.Exists))
    Log.Checkpoint("Results Table is Closed ")
  else
    Log.Warning("Results Table is  NOT Closed ")
  No.Click()
  CloseAnalytic.Click()
  if(!(Aliases.SciexOs.HwndSource_ShellView.VisibleOnScreen.Exists))
    Log.Checkpoint("Analytics Window is Closed ")
  else
    Log.Warning("Analytics Window is NOT Closed")
}

//******************************************************************************************************************************
//Name          -     WaitForObject
//Description   -     Dynamic Delay function
//Parameters    -     ObjName, Timeout
//Return type   -     None   
//*******************************************************************************************************************************
function WaitForObject(ObjName, Timeout)
{
  count =0;
  while(ObjName.Exists ==false && count<=Timeout)
  {
    Delay(1000);
  }
  
}