wx = require("wx")

frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "lua compiler")
panel = wx.wxPanel(frame, -1)
sizer=wx.wxBoxSizer(wx.wxVERTICAL)


sizer:Add(wx.wxStaticText(panel, -1, "Enter the code :"))

calc = wx.wxTextCtrl(panel, -1,"",wx.wxDefaultPosition,wx.wxDefaultSize,wx.wxTE_MULTILINE)
sizer:Add(calc)

getResult = wx.wxButton(panel, -1, "run")
sizer:Add(getResult)
panel:SetSizer(sizer)
getResult:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, function(evt)
    local code =calc:GetValue()
    
    local func, err = loadstring(code)
    
    if func then
        local success, result = pcall(func)
        if success then
            if tostring(result)~="nil" then
                wx.wxMessageBox(tostring(result), "Info")
            end
        else
            wx.wxMessageBox("Error executing code: " .. tostring(result), "Error")
        end
    else
        wx.wxMessageBox (tostring(err), "Error")
    end
end)

frame:Show(true)

wx.wxGetApp():MainLoop()
