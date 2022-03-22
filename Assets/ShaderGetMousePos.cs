using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShaderGetMousePos : MonoBehaviour
{
    private Material mMat = null;

    public Image mImg = null;

    // Start is called before the first frame update
    void Start()
    {
        if ( this.mImg != null )
            this.mMat = this.mImg.material;
    }

    // Update is called once per frame
    void Update()
    {
        if ( this.mMat != null )
        {
            this.mMat.SetVector("_MousePos", Input.mousePosition);
        }
    }
}
