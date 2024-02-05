using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Collision : MonoBehaviour
{
    [SerializeField] Color32 hasPackageColor = new Color32(24,176,156,255);
    [SerializeField] Color32 noPackageColor = new Color32(255,226,46,255);
    
    bool hasPackage = false;
    [SerializeField] float destroyDelay = 1f;
    
    SpriteRenderer spriteRenderer;

    void Start() {
        spriteRenderer = GetComponent<SpriteRenderer>();
    }
    void OnCollisionEnter2D(Collision2D other) 
    {
    }

    void OnTriggerEnter2D(Collider2D other) {

        if(other.tag == "Package" && !hasPackage)
        {
            hasPackage = true;
            Debug.Log("Package Picked Up");
            spriteRenderer.color = hasPackageColor;
            Destroy(other.gameObject,destroyDelay);
        }
        if(other.tag == "Customer" && hasPackage)
        {
            hasPackage = false;
            Debug.Log("Package Delivered");
            spriteRenderer.color = noPackageColor;
        }
    }
}
