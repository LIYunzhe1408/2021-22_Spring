#include "Assistance.h"			// 辅助软件包
#include "QuickSort.h"			// 快速排序算法
#include <cstdlib>
#include <ctime>
#include <chrono>
void Random(int *a,int n,int l,int r)//生成范围在l~r的随机数
{
    srand(time(0));  //设置时间种子
    for(int i=0;i<n;i++){
        a[i]=rand()%(r-l+1)+l;//生成区间r~l的随机数
    }
}

int main(void)
{
    int a[100000];
    int n = 100000;
    Random(a,100000,0,100000);
    auto start = chrono::high_resolution_clock::now();
    QuickSort(a, 0,n-1,n);
    auto end = chrono::high_resolution_clock::now();
    __int64 duration = (end - start).count();
    cout << "程序运行时间：" << setprecision(10)
         << "；  " << duration / 1000000.0 << "ms"
         << endl;
    start = chrono::high_resolution_clock::now();
    QuickSort2<int>(a, n);
    end = chrono::high_resolution_clock::now();
    duration = (end - start).count();
    cout << "改进1后程序运行时间：" << setprecision(10)
         << "；  " << duration / 1000000.0 << "ms"
         << endl;
    start = chrono::high_resolution_clock::now();
    QuickSort3<int>(a,0,n-1);
    end = chrono::high_resolution_clock::now();
    duration = (end - start).count();
    cout << "改进2后程序运行时间：" << setprecision(10)
         << "；  " << duration / 1000000.0 << "ms"
         << endl;

    return 0;
}