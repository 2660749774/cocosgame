<GameFile>
  <PropertyGroup Name="TetrisTipBuyEnergy" Type="Scene" ID="75360a79-7a62-40a8-9d06-103f03681b6d" Version="3.10.0.0" />
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
              <AbstractNodeData Name="inner_bg" ActionTag="-1115372286" Tag="78" IconVisible="False" LeftMargin="103.9771" RightMargin="86.0229" TopMargin="408.2794" BottomMargin="577.7206" ctype="SpriteObjectData">
                <Size X="450.0000" Y="150.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="328.9771" Y="652.7206" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5140" Y="0.5746" />
                <PreSize X="0.7031" Y="0.1320" />
                <FileData Type="Normal" Path="ui/tips/tips_inner_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="icon_title" ActionTag="-802973998" Tag="96" IconVisible="False" LeftMargin="296.2641" RightMargin="299.7359" TopMargin="352.9763" BottomMargin="739.0237" ctype="SpriteObjectData">
                <Size X="44.0000" Y="44.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="318.2641" Y="761.0237" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4973" Y="0.6699" />
                <PreSize X="0.0688" Y="0.0387" />
                <FileData Type="PlistSubImage" Path="energy_bg2.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_title" ActionTag="-1494273943" Tag="81" IconVisible="False" LeftMargin="334.9827" RightMargin="291.0173" TopMargin="360.9763" BottomMargin="747.0237" FontSize="28" LabelText="4" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="14.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="334.9827" Y="761.0237" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5234" Y="0.6699" />
                <PreSize X="0.0219" Y="0.0246" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="0" G="0" B="0" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_close" ActionTag="1204119802" Tag="82" IconVisible="False" LeftMargin="518.7875" RightMargin="56.2125" TopMargin="343.8130" BottomMargin="727.1870" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="35" Scale9Height="43" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="65.0000" Y="65.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="551.2875" Y="759.6870" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8614" Y="0.6687" />
                <PreSize X="0.1016" Y="0.0572" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="close.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_info" ActionTag="-1122246538" Tag="83" IconVisible="False" LeftMargin="242.0000" RightMargin="242.0000" TopMargin="448.9807" BottomMargin="661.0193" FontSize="26" LabelText="体力恢复时间" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="156.0000" Y="26.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="674.0193" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="25" G="76" B="94" />
                <PrePosition X="0.5000" Y="0.5933" />
                <PreSize X="0.2438" Y="0.0229" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="26" G="26" B="26" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_time" ActionTag="-1413043472" Tag="97" IconVisible="False" LeftMargin="287.5000" RightMargin="287.5000" TopMargin="486.9069" BottomMargin="623.0931" FontSize="26" LabelText="14:59" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="65.0000" Y="26.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="636.0931" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="25" G="76" B="94" />
                <PrePosition X="0.5000" Y="0.5599" />
                <PreSize X="0.1016" Y="0.0229" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="26" G="26" B="26" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_buy" ActionTag="1668506547" Tag="79" IconVisible="False" LeftMargin="174.0003" RightMargin="173.9997" TopMargin="658.0000" BottomMargin="392.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0003" Y="435.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.3829" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tips/btn_buy_energy.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tips/btn_buy_energy.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tips/btn_buy_energy.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_watch" ActionTag="40042511" Tag="99" IconVisible="False" LeftMargin="174.0003" RightMargin="173.9997" TopMargin="558.2845" BottomMargin="491.7155" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0003" Y="534.7155" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.4707" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tips/btn_watch_video.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tips/btn_watch_video.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tips/btn_watch_video.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_price" ActionTag="-1943642402" Tag="165" IconVisible="False" LeftMargin="249.0958" RightMargin="376.9042" TopMargin="687.0000" BottomMargin="421.0000" FontSize="28" LabelText="5" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="14.0000" Y="28.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="249.0958" Y="435.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3892" Y="0.3829" />
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