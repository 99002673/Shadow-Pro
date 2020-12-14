function Test7()
{
  //Clicks the 'SplitButton' object.
  Aliases.SciexOs.HwndSource_ShellView.ShellView.workspaceRibbonStackPanel2.SplitButton.Click(57, 12);
  //Clicks the 'New...' item of the 'ContextMenu_' bar.
  Aliases.SciexOs.HwndSource_PopupRoot.PopupRoot.Decorator.NonLogicalAdornerDecorator.ContextMenu_.ClickItem("New...");
}