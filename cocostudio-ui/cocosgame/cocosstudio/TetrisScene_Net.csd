<GameFile>
  <PropertyGroup Name="TetrisScene_Net" Type="Scene" ID="795413a3-2586-4371-9d94-61efcce58dd4" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="scene_bg" ActionTag="-389944647" Tag="64" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-106.8960" RightMargin="-105.1040" TopMargin="-0.9088" BottomMargin="0.9088" LeftEage="281" RightEage="281" TopEage="374" BottomEage="374" Scale9OriginX="281" Scale9OriginY="374" Scale9Width="290" Scale9Height="388" ctype="ImageViewObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="319.1040" Y="568.9088" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4986" Y="0.5008" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/tetris/scene_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="bg_bk" ActionTag="867144031" Tag="63" IconVisible="False" LeftMargin="-14.2451" RightMargin="-14.7549" TopMargin="-16.3300" BottomMargin="239.3300" LeftEage="220" RightEage="220" TopEage="301" BottomEage="301" Scale9OriginX="220" Scale9OriginY="301" Scale9Width="229" Scale9Height="311" ctype="ImageViewObjectData">
                <Size X="669.0000" Y="913.0000" />
                <AnchorPoint />
                <Position X="-14.2451" Y="239.3300" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="-0.0223" Y="0.2107" />
                <PreSize X="1.0453" Y="0.8037" />
                <FileData Type="Normal" Path="ui/tetris/bg_bk.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel_target" ActionTag="1651447180" Tag="40" IconVisible="False" LeftMargin="34.9997" RightMargin="222.0003" TopMargin="34.7600" BottomMargin="828.2400" TouchEnable="True" ClipAble="True" BackColorAlpha="76" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="383.0000" Y="273.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="226.4997" Y="964.7400" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3539" Y="0.8492" />
                <PreSize X="0.5984" Y="0.2403" />
                <SingleColor A="255" R="255" G="0" B="0" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel_self" ActionTag="1060537929" Tag="32" IconVisible="False" LeftMargin="35.0000" RightMargin="222.0000" TopMargin="308.1300" BottomMargin="284.8700" TouchEnable="True" ClipAble="True" BackColorAlpha="76" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="383.0000" Y="543.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="226.5000" Y="556.3700" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3539" Y="0.4898" />
                <PreSize X="0.5984" Y="0.4780" />
                <SingleColor A="255" R="0" G="0" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_bg" ActionTag="-1835008995" Tag="13" IconVisible="False" LeftMargin="35.0000" RightMargin="222.0000" TopMargin="35.0000" BottomMargin="286.0000" ctype="SpriteObjectData">
                <Size X="383.0000" Y="815.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="226.5000" Y="693.5000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3539" Y="0.6105" />
                <PreSize X="0.5984" Y="0.7174" />
                <FileData Type="Normal" Path="ui/tetris/bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down_low" ActionTag="618124103" Tag="15" IconVisible="False" LeftMargin="125.3403" RightMargin="418.6597" TopMargin="1019.4208" BottomMargin="20.5792" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.3403" Y="68.5792" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2708" Y="0.0604" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="Normal" Path="ui/tetris/down.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/down.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/down.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down" ActionTag="1650258263" Tag="42" IconVisible="False" LeftMargin="125.6924" RightMargin="418.3076" TopMargin="873.9659" BottomMargin="166.0341" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.6924" Y="214.0341" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2714" Y="0.1884" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="Normal" Path="ui/tetris/down_fast.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/down_fast.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/down_fast.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_score" ActionTag="-1933401380" Tag="65" IconVisible="False" LeftMargin="451.0427" RightMargin="68.9573" TopMargin="134.0876" BottomMargin="951.9124" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="120.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="511.0427" Y="976.9124" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7985" Y="0.8600" />
                <PreSize X="0.1875" Y="0.0440" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/number.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="next_bg" ActionTag="-1369861544" Tag="71" IconVisible="False" LeftMargin="468.9219" RightMargin="81.0781" TopMargin="399.1130" BottomMargin="646.8870" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="90.0000" Y="90.0000" />
                <AnchorPoint />
                <Position X="468.9219" Y="646.8870" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7327" Y="0.5694" />
                <PreSize X="0.1406" Y="0.0792" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="next_bg_title" ActionTag="1665194029" Tag="66" IconVisible="False" LeftMargin="470.9675" RightMargin="89.0325" TopMargin="487.7642" BottomMargin="618.2358" LeftEage="26" RightEage="26" TopEage="9" BottomEage="9" Scale9OriginX="26" Scale9OriginY="9" Scale9Width="28" Scale9Height="12" ctype="ImageViewObjectData">
                <Size X="80.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="510.9675" Y="633.2358" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7984" Y="0.5574" />
                <PreSize X="0.1250" Y="0.0264" />
                <FileData Type="Normal" Path="ui/tetris/NEXT.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_play" ActionTag="608945743" Tag="41" IconVisible="False" LeftMargin="132.5428" RightMargin="267.4572" TopMargin="381.7950" BottomMargin="634.2050" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="210" Scale9Height="98" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="240.0000" Y="120.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="252.5428" Y="694.2050" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3946" Y="0.6111" />
                <PreSize X="0.3750" Y="0.1056" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <PressedFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <NormalFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_shift" ActionTag="-1740025647" Tag="27" IconVisible="False" LeftMargin="450.7410" RightMargin="36.2590" TopMargin="943.0548" BottomMargin="39.9452" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="123" Scale9Height="131" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="153.0000" Y="153.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="527.2410" Y="116.4452" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8238" Y="0.1025" />
                <PreSize X="0.2391" Y="0.1347" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="Normal" Path="ui/tetris/shift.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/shift.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/shift.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_right" ActionTag="-1978374155" Tag="26" IconVisible="False" LeftMargin="222.1837" RightMargin="321.8163" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="270.1837" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4222" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="Normal" Path="ui/tetris/right.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/right.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/right.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_left" ActionTag="-780245045" Tag="25" IconVisible="False" LeftMargin="31.0177" RightMargin="512.9823" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="79.0177" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1235" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="Normal" Path="ui/tetris/left.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/left.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/left.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="del_line" ActionTag="-1212860882" Tag="68" IconVisible="False" LeftMargin="473.8242" RightMargin="110.1758" TopMargin="720.5052" BottomMargin="396.4948" ctype="SpriteObjectData">
                <Size X="56.0000" Y="19.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="501.8242" Y="405.9948" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7841" Y="0.3574" />
                <PreSize X="0.0875" Y="0.0167" />
                <FileData Type="Normal" Path="ui/tetris/del_line.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="hang" ActionTag="-1919698513" Tag="69" IconVisible="False" LeftMargin="528.6436" RightMargin="91.3564" TopMargin="720.0039" BottomMargin="395.9961" ctype="SpriteObjectData">
                <Size X="20.0000" Y="20.0000" />
                <AnchorPoint ScaleX="0.4497" ScaleY="0.4381" />
                <Position X="537.6376" Y="404.7581" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8401" Y="0.3563" />
                <PreSize X="0.0313" Y="0.0176" />
                <FileData Type="Normal" Path="ui/tetris/hang.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_hang" ActionTag="2123746600" Tag="72" IconVisible="False" LeftMargin="495.5633" RightMargin="114.4367" TopMargin="752.1444" BottomMargin="368.8556" CharWidth="10" CharHeight="15" LabelText="100" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="30.0000" Y="15.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="510.5633" Y="376.3556" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7978" Y="0.3313" />
                <PreSize X="0.0469" Y="0.0132" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/small number.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="568.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>