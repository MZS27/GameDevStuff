using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallScript : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] float ballStartX = -5f;
    [SerializeField] float ballStartY = 0f;
    void Start()
    {
        this.GetComponent<Rigidbody2D>().velocity = new Vector2(ballStartX,ballStartY);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
