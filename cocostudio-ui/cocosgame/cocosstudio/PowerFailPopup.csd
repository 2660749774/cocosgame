<GameFile>
  <PropertyGroup Name="PowerFailPopup" Type="Scene" ID="dc8f6576-45cb-4624-a062-b32841ee6468" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="47" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1253254083" Tag="115" IconVisible="False" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="popup_bg_4" ActionTag="-206761658" Tag="51" IconVisible="False" TopMargin="134.5000" BottomMargin="286.5000" ctype="SpriteObjectData">
                <Size X="640.0000" Y="715.0000" />
                <Children>
                  <AbstractNodeData Name="btn_powerretry" ActionTag="-1684696655" Tag="20" IconVisible="False" LeftMargin="174.0000" RightMargin="174.0000" TopMargin="538.0000" BottomMargin="91.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="292.0000" Y="86.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="134.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.1874" />
                    <PreSize X="0.4563" Y="0.1203" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Normal" Path="ui/tetris/power/power_fail_retry.png" Plist="" />
                    <PressedFileData Type="Normal" Path="ui/tetris/power/power_fail_retry.png" Plist="" />
                    <NormalFileData Type="Normal" Path="ui/tetris/power/power_fail_retry.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="sp_target" ActionTag="1638011431" Tag="368" IconVisible="False" LeftMargin="297.0000" RightMargin="297.0000" TopMargin="285.2587" BottomMargin="383.7413" ctype="SpriteObjectData">
                    <Size X="46.0000" Y="46.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="406.7413" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5689" />
                    <PreSize X="0.0719" Y="0.0643" />
                    <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_target_title" ActionTag="-1522548448" Tag="367" IconVisible="False" LeftMargin="283.5000" RightMargin="283.5000" TopMargin="223.9601" BottomMargin="454.0399" FontSize="32" LabelText="目 标" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="73.0000" Y="37.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="472.5399" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.6609" />
                    <PreSize X="0.1141" Y="0.0517" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="55" G="168" B="245" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_target" ActionTag="1158400764" Tag="366" IconVisible="False" LeftMargin="224.0000" RightMargin="224.0000" TopMargin="358.1520" BottomMargin="319.8480" FontSize="32" LabelText="清理岩石方块" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="192.0000" Y="37.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="338.3480" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.4732" />
                    <PreSize X="0.3000" Y="0.0517" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="55" G="168" B="245" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="powername_bg_2" ActionTag="-1411249087" Tag="49" IconVisible="False" LeftMargin="182.0000" RightMargin="182.0000" TopMargin="17.5000" BottomMargin="622.5000" ctype="SpriteObjectData">
                    <Size X="276.0000" Y="75.0000" />
                    <Children>
                      <AbstractNodeData Name="lb_powername" ActionTag="-2057125422" Tag="52" IconVisible="False" LeftMargin="86.1547" RightMargin="89.8453" TopMargin="18.5402" BottomMargin="19.4598" FontSize="32" LabelText="第 5 关" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                        <Size X="100.0000" Y="37.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="136.1547" Y="37.9598" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.4933" Y="0.5061" />
                        <PreSize X="0.3623" Y="0.4933" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="0" G="0" B="0" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="660.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.9231" />
                    <PreSize X="0.4313" Y="0.1049" />
                    <FileData Type="Normal" Path="ui/tetris/power/powername_bg.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="btn_close" ActionTag="-186577946" Tag="279" IconVisible="False" LeftMargin="525.7432" RightMargin="49.2568" TopMargin="15.0259" BottomMargin="634.9741" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="35" Scale9Height="43" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="65.0000" Y="65.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="558.2432" Y="667.4741" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.8723" Y="0.9335" />
                    <PreSize X="0.1016" Y="0.0909" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Normal" Path="ui/tetris/power/close.png" Plist="" />
                    <PressedFileData Type="Normal" Path="ui/tetris/power/close.png" Plist="" />
                    <NormalFileData Type="Normal" Path="ui/tetris/power/close.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_fail" ActionTag="196555763" Tag="369" IconVisible="False" LeftMargin="128.0000" RightMargin="128.0000" TopMargin="456.3398" BottomMargin="221.6602" FontSize="32" LabelText="真遗憾，离成功就差一点点" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="384.0000" Y="37.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="320.0000" Y="240.1602" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.3359" />
                    <PreSize X="0.6000" Y="0.0517" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="55" G="168" B="245" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="644.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5669" />
                <PreSize X="1.0000" Y="0.6294" />
                <FileData Type="Normal" Path="ui/tetris/power/power_fail_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
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