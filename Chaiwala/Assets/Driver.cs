using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Driver : MonoBehaviour
{
    float baseMoveSpeed = 15;
    [SerializeField]float steerSpeed = 300;
    [SerializeField]float moveSpeed = 15;
    [SerializeField]float boostSpeed = 20;
    [SerializeField]float bumpSpeed = 10;
    void Start()
    {
        
    }

    void Update()
    {
        float steerAmount = Input.GetAxis("Horizontal") * steerSpeed * Time.deltaTime;
        float moveAmount = Input.GetAxis("Vertical") * moveSpeed * Time.deltaTime;
        transform.Translate(0,moveAmount,0);
        transform.Rotate(0,0,-steerAmount);
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if(other.tag == "Boost")
        {
            Debug.Log("BOOST!");
            if(moveSpeed == bumpSpeed)
            {
                moveSpeed = baseMoveSpeed;
            }
            else
            {
                moveSpeed = boostSpeed;
            }
        }
        if(other.tag == "Bump")
        {
            Debug.Log("Buuuump");
            if(moveSpeed == boostSpeed)
            {
                moveSpeed = baseMoveSpeed;
            }
            else
            {
                moveSpeed = bumpSpeed;
            }
        }
    }

}
