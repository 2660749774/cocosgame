<GameFile>
  <PropertyGroup Name="TetrisTipBuyTime" Type="Scene" ID="08819dde-2f47-43b0-90d5-801e4df0c2c1" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="47" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1253254083" Tag="115" IconVisible="False" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="500232067" Tag="77" IconVisible="False" LeftMargin="-106.0000" RightMargin="-106.0000" TopMargin="433.0000" BottomMargin="433.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="270.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3312" Y="0.2377" />
                <FileData Type="Normal" Path="ui/bg/intro_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_close" ActionTag="1204119802" Tag="82" IconVisible="False" LeftMargin="586.0406" RightMargin="-11.0406" TopMargin="491.3901" BottomMargin="579.6099" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="35" Scale9Height="43" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="65.0000" Y="65.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="618.5406" Y="612.1099" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.9665" Y="0.5388" />
                <PreSize X="0.1016" Y="0.0572" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_info" ActionTag="-1122246538" Tag="83" IconVisible="False" LeftMargin="160.0000" RightMargin="160.0000" TopMargin="546.6441" BottomMargin="556.3559" FontSize="32" LabelText="延长关卡时间：15秒！" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="320.0000" Y="33.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="572.8559" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="0" G="0" B="0" />
                <PrePosition X="0.5000" Y="0.5043" />
                <PreSize X="0.5000" Y="0.0290" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="26" G="26" B="26" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_buy" ActionTag="1668506547" Tag="79" IconVisible="False" LeftMargin="174.0000" RightMargin="174.0000" TopMargin="590.1500" BottomMargin="459.8500" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="502.8500" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.4426" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="btn_buy_time.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="btn_buy_time.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="btn_buy_time.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_price" ActionTag="-212368999" Tag="153" IconVisible="False" LeftMargin="250.0958" RightMargin="375.9042" TopMargin="619.1500" BottomMargin="488.8500" FontSize="28" LabelText="5" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="14.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="250.0958" Y="502.8500" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3908" Y="0.4426" />
                <PreSize X="0.0219" Y="0.0246" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="568.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>