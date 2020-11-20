using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RaymarchShape : MonoBehaviour {

    enum ShapeType {
        NONE,
        SPHERE,
        CUBE,
        CYLINDER,
        BLACK_HOLE,
        DISK
    }

    [SerializeField]
    private ShapeType shape = ShapeType.NONE;

    [SerializeField]
    private Vector3 size = Vector3.one;

    [SerializeField]
    private Color surfaceColor = Color.white;

    private Matrix4x4 trsMatrix;

    public Vector3 GetPosition() {
        return transform.position;
    }

    public int GetShape() {
        return (int) shape;
    }

    public Color GetSurfaceColor() {
        return surfaceColor;
    }

    public Vector2 GetSize() {
        return size;
    }

    public Vector3 GetRotation() {
        return transform.rotation.eulerAngles * Mathf.Deg2Rad;
    }

    public Matrix4x4 TRSMatrix {
        get {
            return Matrix4x4.TRS(transform.position, transform.rotation, transform.lossyScale);
        }
    }

}
