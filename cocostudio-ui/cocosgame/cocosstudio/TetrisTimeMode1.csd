<GameFile>
  <PropertyGroup Name="TetrisTimeMode" Type="Scene" ID="1b6eef34-cfb2-4e8c-8406-b7bc22a90c71" Version="3.10.0.0" />
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
              <AbstractNodeData Name="bg_bk" ActionTag="867144031" Tag="63" IconVisible="False" LeftMargin="-14.2451" RightMargin="-14.7549" TopMargin="-16.3331" BottomMargin="239.3331" LeftEage="220" RightEage="220" TopEage="301" BottomEage="301" Scale9OriginX="220" Scale9OriginY="301" Scale9Width="229" Scale9Height="311" ctype="ImageViewObjectData">
                <Size X="669.0000" Y="913.0000" />
                <AnchorPoint />
                <Position X="-14.2451" Y="239.3331" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="-0.0223" Y="0.2107" />
                <PreSize X="1.0453" Y="0.8037" />
                <FileData Type="Normal" Path="ui/tetris/bg_bk.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel" ActionTag="1060537929" Tag="32" IconVisible="False" LeftMargin="35.0000" RightMargin="222.0000" TopMargin="35.0000" BottomMargin="286.0000" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="383.0000" Y="815.0000" />
                <Children>
                  <AbstractNodeData Name="tetris_bg" ActionTag="-1835008995" Tag="13" IconVisible="False" ctype="SpriteObjectData">
                    <Size X="383.0000" Y="815.0000" />
                    <AnchorPoint />
                    <Position />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition />
                    <PreSize X="1.0000" Y="1.0000" />
                    <FileData Type="Normal" Path="ui/tetris/bg.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="226.5000" Y="693.5000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3539" Y="0.6105" />
                <PreSize X="0.5984" Y="0.7174" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
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
              <AbstractNodeData Name="lb_score_title" ActionTag="1780421741" Tag="26" IconVisible="False" LeftMargin="481.1556" RightMargin="94.8444" TopMargin="264.4195" BottomMargin="839.5805" FontSize="28" LabelText="分 数" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="64.0000" Y="32.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="513.1556" Y="855.5805" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8018" Y="0.7532" />
                <PreSize X="0.1000" Y="0.0282" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_score" ActionTag="-1933401380" Tag="65" IconVisible="False" LeftMargin="454.0000" RightMargin="66.0000" TopMargin="314.2162" BottomMargin="771.7838" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="120.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="514.0000" Y="796.7838" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8031" Y="0.7014" />
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
              <AbstractNodeData Name="btn_play" ActionTag="608945743" Tag="41" IconVisible="False" LeftMargin="110.1754" RightMargin="289.8246" TopMargin="392.7013" BottomMargin="623.2987" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="210" Scale9Height="98" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="240.0000" Y="120.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="230.1754" Y="683.2987" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3596" Y="0.6015" />
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
              <AbstractNodeData Name="del_line" Visible="False" ActionTag="-1212860882" VisibleForFrame="False" Tag="68" IconVisible="False" LeftMargin="473.8242" RightMargin="110.1758" TopMargin="720.5052" BottomMargin="396.4948" ctype="SpriteObjectData">
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
              <AbstractNodeData Name="hang" Visible="False" ActionTag="-1919698513" VisibleForFrame="False" Tag="69" IconVisible="False" LeftMargin="528.6436" RightMargin="91.3564" TopMargin="720.0039" BottomMargin="395.9961" ctype="SpriteObjectData">
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
              <AbstractNodeData Name="lb_hang" Visible="False" ActionTag="2123746600" VisibleForFrame="False" Tag="72" IconVisible="False" LeftMargin="495.5633" RightMargin="114.4367" TopMargin="752.1444" BottomMargin="368.8556" CharWidth="10" CharHeight="15" LabelText="100" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="30.0000" Y="15.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="510.5633" Y="376.3556" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7978" Y="0.3313" />
                <PreSize X="0.0469" Y="0.0132" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/small number.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_time_title" ActionTag="1484233355" Tag="105" IconVisible="False" LeftMargin="476.7966" RightMargin="91.2034" TopMargin="107.5281" BottomMargin="996.4720" FontSize="28" LabelText="时  间" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="72.0000" Y="32.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="512.7966" Y="1012.4720" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8012" Y="0.8913" />
                <PreSize X="0.1125" Y="0.0282" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_time" ActionTag="1146390414" Tag="85" IconVisible="False" LeftMargin="454.0000" RightMargin="66.0000" TopMargin="155.0000" BottomMargin="931.0000" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="120.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="514.0000" Y="956.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8031" Y="0.8415" />
                <PreSize X="0.1875" Y="0.0440" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/number.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_left_line_title" ActionTag="1185045856" Tag="24" IconVisible="False" LeftMargin="449.5965" RightMargin="70.4035" TopMargin="688.7273" BottomMargin="415.2727" FontSize="28" LabelText=" 剩余块数" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="120.0000" Y="32.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="509.5965" Y="431.2727" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7962" Y="0.3796" />
                <PreSize X="0.1875" Y="0.0282" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_left_line" ActionTag="2089445126" Tag="25" IconVisible="False" LeftMargin="482.5682" RightMargin="97.4318" TopMargin="729.5707" BottomMargin="356.4293" CharWidth="30" CharHeight="50" LabelText="10" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="60.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="512.5682" Y="381.4293" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8009" Y="0.3358" />
                <PreSize X="0.0938" Y="0.0440" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/number.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_needscore_title" ActionTag="2060202547" Tag="52" IconVisible="False" LeftMargin="457.5211" RightMargin="70.4789" TopMargin="545.5465" BottomMargin="558.4535" FontSize="28" LabelText="通关分数" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="112.0000" Y="32.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="513.5211" Y="574.4535" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8024" Y="0.5057" />
                <PreSize X="0.1750" Y="0.0282" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_needscore" ActionTag="-1524289185" Tag="53" IconVisible="False" LeftMargin="453.3664" RightMargin="66.6336" TopMargin="580.8007" BottomMargin="505.1993" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="120.0000" Y="50.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="513.3664" Y="530.1993" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8021" Y="0.4667" />
                <PreSize X="0.1875" Y="0.0440" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/tetris/number.png" Plist="" />
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