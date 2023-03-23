<?php

namespace App\Http\Controllers;

use App\Transaksi;
use Illuminate\Http\Request;
use DB;

class TransaksiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = NULL;
        return view('transaksi.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Transaksi  $transaksi
     * @return \Illuminate\Http\Response
     */
    public function show(Transaksi $transaksi)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Transaksi  $transaksi
     * @return \Illuminate\Http\Response
     */
    public function edit(Transaksi $transaksi)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Transaksi  $transaksi
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Transaksi $transaksi)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Transaksi  $transaksi
     * @return \Illuminate\Http\Response
     */
    public function destroy(Transaksi $transaksi)
    {
        //
    }

    public function checkDoc(Request $request){
        // dd($request->get('doc'));
        // cek ke db
        $docNum = strtoupper($request->get('doc'));
        // dd($docNum);
        $check = DB::table('TrxHdr')->select()->where('DocNo','=',$docNum)->get();
        // dd($check);
        // kalau ada, cari detail transaksi
        if(empty($check)){
            // dd("ada transaksi");
            // MySQL Query
            // SELECT mstproduct.ProdCode, mstproduct.ProdName,mstcustomer.CustCode, mstcustomer.CustName, mstproductprice.UnitPrice,mstproduct.Content, trxdtl.QtyBig, mstproduct.UMBig, trxdtl.QtySmall, mstproduct.UMSmall, trxdtl.BonusCode, trxdtl.QtyBonus, trxdtl.GrossPrice,trxhdr.DocDate,trxhdr.Notes, trxhdr.DocDate
            // FROM mstcustomer
            // INNER JOIN trxhdr ON trxhdr.CustCode = mstcustomer.CustCode
            // INNER JOIN trxdtl ON trxdtl.DocNo = trxhdr.DocNo
            // INNER JOIN mstproduct ON mstproduct.ProdCode = trxdtl.ProdCode
            // INNER JOIN mstproductprice ON mstproductprice.ProdCode = mstproduct.ProdCode
            // WHERE trxhdr.DocNo = 'DOC-1'
            // GROUP BY mstproduct.ProdCode;
            $data = DB::table('mstcustomer')
                    ->join('trxhdr','trxhdr.CustCode','=','mstCustomer.CustCode')
                    ->join('trxdtl','trxdtl.DocNo','=','trxhdr.DocNo')
                    ->join('mstproduct','mstproduct.ProdCode','=','trxdtl.ProdCode')
                    ->join('mstproductprice','mstproductprice.ProdCode','=','mstproduct.ProdCode')
                    ->select("mstproduct.ProdCode", "mstproduct.ProdName","mstcustomer.CustCode", "mstcustomer.CustName", "mstproductprice.UnitPrice","mstproduct.Content", "trxdtl.QtyBig", "mstproduct.UMBig", "trxdtl.QtySmall", "mstproduct.UMSmall", "trxdtl.BonusCode", "trxdtl.QtyBonus", "trxdtl.GrossPrice","trxhdr.DocDate","trxhdr.Notes", "trxhdr.DocDate")
                    ->where('trxhdr.DocNo','=',$docNum)
                    ->groupBy('mstproduct.ProdCode')
                    ->get();
        }else{
            // dd("tidak ada transaksi");
            $data = NULL;
        }
        return response()->json(array(
            'status'=>'OK',
            'msg'=>view('transaksi.index', compact('data'))->render()
        ), 200);
    }

    public function deleteData(Request $request){
        // hapus document dari db
        try{
            $trxdtl = DB::table('trxdtl')->where('DocNo', $request->get('docNo'))->delete();
            $trxhdr = DB::table('trxhdr')->where('DocNo', $request->get('docNo'))->delete();

            $request->session()->flash('status','Dokumen berhasil dihapus');
        }catch (\PDOException $e) {
            $request->session()->flash('error', 'Gagal menghapus dokumen, silahkan coba lagi');
        }  
    }
}
