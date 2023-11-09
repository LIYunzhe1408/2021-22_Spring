#ifndef __QUICK_SORT_H__
#define __QUICK_SORT_H__

template <class ElemType>
void QuickSort(ElemType elem[], int low, int high, int n)
// 操作结果:对数组elem[low .. high]中的元素进行快速排序
{
    ElemType e = elem[low];				// 取枢轴元素
    int i = low, j = high;
    while (i < j)	{
        while (i < j && elem[j] >= e)	// 使j右边的元素不小于枢轴元素
            j--;
        if (i < j)
            elem[i++] = elem[j];

        while (i < j && elem[i] <= e)	// 使i左边的元素不大于枢轴元素
            i++;
        if (i < j)
            elem[j--] = elem[i];
    }
    elem[i] = e;
//    cout << "排序区间：" << low << "--" << high << ";中枢位置为：" << i << endl;
//    Display(elem, n);
//    cout << endl;
    if (low < i-1)	QuickSort(elem, low, i - 1, n);		// 对子表elem[low, i - 1]递归排序
    if (i + 1 < high) QuickSort(elem, i + 1, high, n);	// 对子表elem[i + 1, high]递归排序
}


template<class T>//返回左端，右端，中心元素的中值的位置
int GetMid(T* begin, int Len) {
    if (Len <= 1)
        return 0;
    int a = begin[0], b = begin[Len / 2], c = begin[Len-1];
    int m = std::max(a, b), n = std::max(b, c);
    if (m == n)
        if (a > c)
            return 0;
        else
            return Len-1;
    else if (m != b && n!= b)
        if (a > c)
            return Len-1;
        else
            return 0;
    else
        return Len / 2;

}


template<class T>   //快速排序
int quick_sort_(T* begin, int Len) {

    T* A = begin;
    int mid = GetMid<int>(begin, Len);  //中位
    std::swap(A[mid], A[0]);            //把中位数换到第一位
    int Tem = A[0];                     //选取比较的基准，其位置也就是初始的坑位
    int i = 0, j = Len - 1;
    while(i < j) {
        while (A[j] >= Tem && i < j)
            j--;
        if(i < j)
            A[i++] = A[j];
        while (A[i] <= Tem && i < j)
            i++;
        if (i < j)
            A[j--] = A[i];
    }
    A[j] = Tem;
    return j;
}


template<class T>
void QuickSort2(T* A, int Len) //取三者中关键字居中者作为基准元素的改进方法
{
    if (Len <= 1) return;
    int k = quick_sort_(A, Len);
    QuickSort2<int>(A, k);
    QuickSort2<int>(&A[k + 1], Len - k - 1);
}
template<class T>
void QuickSort3(T* elem,int low,int high)//随机选取基准元素的改进方法
{
    srand((unsigned)time(NULL));  //设置随机数，随机选取枢轴元素
    int pos = rand()%(high - low) + low;
    T e=elem[pos];
    int i = low, j = high;
    while (i < j)	{
        while (i < j && elem[j] >= e)	// 使j右边的元素不小于枢轴元素
            j--;
        if (i < j)
            elem[i++] = elem[j];

        while (i < j && elem[i] <= e)	// 使i左边的元素不大于枢轴元素
            i++;
        if (i < j)
            elem[j--] = elem[i];
    }
    elem[i] = e;
    if (low < i-1)	QuickSort3(elem, low, i - 1);		// 对子表elem[low, i - 1]递归排序
    if (i + 1 < high) QuickSort3(elem, i + 1, high);	// 对子表elem[i + 1, high]递归排序
}
#endif

