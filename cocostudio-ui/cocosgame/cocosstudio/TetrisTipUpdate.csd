<GameFile>
  <PropertyGroup Name="TetrisTipUpdate" Type="Scene" ID="59576290-5f4a-4eba-9329-8432e6aad0a2" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="47" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1253254083" Tag="115" IconVisible="False" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="500232067" Tag="77" IconVisible="False" LeftMargin="7.5000" RightMargin="7.5000" TopMargin="333.0000" BottomMargin="333.0000" ctype="SpriteObjectData">
                <Size X="625.0000" Y="470.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="0.9766" Y="0.4137" />
                <FileData Type="Normal" Path="ui/tips/tips_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="inner_bg" ActionTag="-314910390" Tag="60" IconVisible="False" LeftMargin="95.0000" RightMargin="95.0000" TopMargin="414.0000" BottomMargin="522.0000" Scale9Enable="True" LeftEage="148" RightEage="148" TopEage="49" BottomEage="49" Scale9OriginX="148" Scale9OriginY="49" Scale9Width="154" Scale9Height="52" ctype="ImageViewObjectData">
                <Size X="450.0000" Y="200.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="622.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5475" />
                <PreSize X="0.7031" Y="0.1761" />
                <FileData Type="Normal" Path="ui/tips/tips_inner_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_title" ActionTag="-1494273943" Tag="81" IconVisible="False" LeftMargin="264.0000" RightMargin="264.0000" TopMargin="360.2831" BottomMargin="747.7169" FontSize="28" LabelText="游戏更新" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="112.0000" Y="28.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="761.7169" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.6705" />
                <PreSize X="0.1750" Y="0.0246" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="0" G="0" B="0" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_info" ActionTag="-1122246538" Tag="83" IconVisible="False" LeftMargin="138.0000" RightMargin="138.0000" TopMargin="488.1180" BottomMargin="595.8820" FontSize="26" LabelText="检查到有新的版本，点击更新。&#xA;本次更新大小：1M" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="364.0000" Y="52.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="621.8820" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="165" B="0" />
                <PrePosition X="0.5000" Y="0.5474" />
                <PreSize X="0.5688" Y="0.0458" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="61" G="136" B="171" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_ok" ActionTag="1668506547" Tag="79" IconVisible="False" LeftMargin="174.0002" RightMargin="173.9998" TopMargin="626.9994" BottomMargin="423.0006" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0002" Y="466.0006" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.4102" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
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