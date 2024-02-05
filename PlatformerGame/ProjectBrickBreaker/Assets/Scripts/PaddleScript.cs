using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaddleScript : MonoBehaviour
{
    [SerializeField] float moveSpeed = 5f;
    [SerializeField] float rotateSpeed = 5000f;

    float moveAmount = 0;
    float rotateAmount = 0;

    float paddleUpperLimit = 4.14f;
    float paddleLowerLimit = -4.14f;

    float transformPosX;
    
    void Start()
    {
        transformPosX = transform.position.x;
    }

    void Update()
    {

        if(Input.GetKey(KeyCode.UpArrow) && transform.position.y <= paddleUpperLimit)
        {
            moveAmount = moveSpeed * Time.deltaTime;
            transform.position = transform.position + new Vector3(0,moveAmount,0);        
        }        
        if(Input.GetKey(KeyCode.DownArrow) && transform.position.y >= paddleLowerLimit)
        {
            moveAmount = moveSpeed * Time.deltaTime;
            transform.position = transform.position + new Vector3(0,-moveAmount,0);
        }

        rotateAmount = Input.GetAxis("Horizontal") * rotateSpeed * Time.deltaTime;
        transform.Rotate(0,0,-rotateAmount);

    }
}
