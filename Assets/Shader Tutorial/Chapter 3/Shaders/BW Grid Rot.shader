Shader "Unlit/BW Grid Rot"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma enable_d3d11_debug_symbols

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float4x4 Mat = float4x4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1);
                fixed Rad = radians((_Time.y % 360.0f) * 30.0f );

                Mat._m00 = cos(Rad);
                Mat._m01 = sin(Rad);
                Mat._m10 = -sin(Rad);
                Mat._m11 = cos(Rad);

                i.uv = (i.uv * 2.0f) - 1.0f;
                i.uv = mul(Mat, i.uv);
                i.uv = (i.uv + 1.0f) * 0.5f;

                fixed4 col = tex2D(_MainTex, i.uv);

                fixed column = floor(i.uv.x / 0.1f);
                fixed row = floor(i.uv.y / 0.1f);

                column += floor(row % 2.0f);

                col.w = 1.0f;
                col.xyz = floor(column % 2.0f);
                return col;
            }
            ENDCG
        }
    }
}