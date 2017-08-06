<GameFile>
  <PropertyGroup Name="TetrisRank" Type="Scene" ID="2f894d0c-a688-4ecb-8992-e179916341b4" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="layer_bg" ActionTag="727534625" Tag="51" IconVisible="False" LeftMargin="-105.0000" RightMargin="-105.0000" ctype="SpriteObjectData">
                <Size X="850.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3281" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/pvp_bg.png" Plist="" />
                <BlendFunc Src="770" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bg" ActionTag="-1366817247" Tag="89" IconVisible="False" LeftMargin="-106.0000" RightMargin="-106.0000" TopMargin="48.0000" BottomMargin="48.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="1040.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="0.9000" ScaleY="0.9000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3312" Y="0.9155" />
                <FileData Type="Normal" Path="ui/rank/rank_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="list_view" ActionTag="-1725103638" Tag="90" IconVisible="False" LeftMargin="0.0003" RightMargin="-0.0003" TopMargin="369.9967" BottomMargin="126.0033" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" IsBounceEnabled="True" ScrollDirectionType="0" ItemMargin="2" DirectionType="Vertical" HorizontalType="Align_HorizontalCenter" ctype="ListViewObjectData">
                <Size X="640.0000" Y="640.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0003" Y="446.0033" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.3926" />
                <PreSize X="1.0000" Y="0.5634" />
                <SingleColor A="255" R="150" G="150" B="255" />
                <FirstColor A="255" R="150" G="150" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="sp_self" ActionTag="-954620471" Tag="91" IconVisible="False" LeftMargin="-7.4999" RightMargin="-7.5001" TopMargin="255.5000" BottomMargin="765.5000" ctype="SpriteObjectData">
                <Size X="655.0000" Y="115.0000" />
                <Children>
                  <AbstractNodeData Name="lb_ranktitle" ActionTag="585293688" Tag="92" IconVisible="False" LeftMargin="39.5654" RightMargin="455.4346" TopMargin="38.5000" BottomMargin="43.5000" FontSize="32" LabelText="我的排名：" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="160.0000" Y="33.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="39.5654" Y="60.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.0604" Y="0.5217" />
                    <PreSize X="0.2443" Y="0.2870" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="64" G="57" B="53" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_myrank" ActionTag="854758408" Tag="187" IconVisible="False" LeftMargin="197.9945" RightMargin="409.0055" TopMargin="38.5000" BottomMargin="43.5000" FontSize="32" LabelText="123" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="48.0000" Y="33.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="197.9945" Y="60.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.3023" Y="0.5217" />
                    <PreSize X="0.0733" Y="0.2870" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="64" G="57" B="53" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="btn_recv" ActionTag="-190716961" Tag="93" IconVisible="False" LeftMargin="428.7226" RightMargin="56.2774" TopMargin="25.0000" BottomMargin="30.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="140" Scale9Height="38" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="170.0000" Y="60.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="513.7226" Y="60.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.7843" Y="0.5217" />
                    <PreSize X="0.2595" Y="0.5217" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="PlistSubImage" Path="btn_recv.png" Plist="ui/plist/common.plist" />
                    <PressedFileData Type="PlistSubImage" Path="btn_recv.png" Plist="ui/plist/common.plist" />
                    <NormalFileData Type="PlistSubImage" Path="btn_recv.png" Plist="ui/plist/common.plist" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0001" Y="823.0000" />
                <Scale ScaleX="0.9000" ScaleY="0.9000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.7245" />
                <PreSize X="1.0234" Y="0.1012" />
                <FileData Type="Normal" Path="ui/rank/rank_self_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
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