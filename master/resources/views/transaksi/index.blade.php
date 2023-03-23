<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://use.fontawesome.com/3309a1a9ca.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<style>
    table,
    th,
    td {
        border: 1px solid black;
        border-collapse: collapse;
    }
</style>
{{-- Alert session terima dari controller --}}
@if (session('status'))
    <div class="alert alert-success alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick=""><span
                aria-hidden="true">×</span>
        </button>
        <strong>Sukses!</strong> {{ session('status') }}
        @if (Session::has('status'))
            {{ Session::forget('status') }}
        @endif
    </div>
@elseif(session('error'))
    <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">x</span>
        </button>
        <strong>Gagal!</strong> {{ session('error') }}
        {{ Session::forget('error') }}
    </div>
@endif
<form method="POST" action="">
    @csrf
    <div class="form-group">
        <label>Nomor Document</label>
        <input type="text" class="form-control" id="docNumber" name="docNumber" placeholder="Masukkan nomor dokumen">
    </div>
    <div class="form-group">
        <label>Tanggal</label>
        <input type="date" class="form-control" id="date" name="date" disabled>
    </div>
    <div class="form-group">
        <label>Customer</label>
        <input type="text" class="form-control" id="custNumber" name="custNumber"
            placeholder="Masukkan nomor customer" disabled>
    </div>
    <div class="form-group">
        <label>Nama Customer</label>
        <input type="text" class="form-control" id="custName" name="custName" placeholder="Masukkan nama customer"
            disabled>
    </div>
    <div class="form-group">
        <label>Notes</label>
        <textarea class="form-control" id="notes" name="notes" placeholder="Masukkan catatan" disabled></textarea>
    </div>
    <div class="form-group">
        <label>Product</label>
        <input type="text" class="form-control" id="prodCode" name="prodCode" placeholder="Masukkan kode produk"
            disabled>
    </div>
    <div class="form-group">
        <label>Nama Product</label>
        <input type="text" class="form-control" id="prodName" name="prodName" placeholder="Masukkan nama produk"
            disabled>
    </div>
    <div class="form-group">
        <label>Unit Price</label>
        <input type="text" class="form-control" id="unitPrice" name="unitPrice" placeholder="Masukkan harga"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" disabled>
    </div>
    <div class="form-group">
        <label>Content</label>
        <input type="text" class="form-control" id="content" name="content" placeholder="Masukkan harga"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" disabled>
    </div>
    <div class="form-group">
        <label>Quantity DOS</label>
        <input type="text" class="form-control" id="dos" name="dos"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" disabled>
    </div>
    <div class="form-group">
        <label>Quantity PCS</label>
        <input type="text" class="form-control" id="dos" name="dos"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" disabled>
    </div>

    <button type="button" id="btnConfirm" class="btn btn-secondary">Confirm</button>
    <button type="button" id="btnDelete" class="btn btn-danger">Delete</button>
    <button type="button" id="btnSubmit" class="btn btn-primary">Save</button>
</form>
<br>
<table style="width:100%">
    <thead>
        <tr>
            <th>ProdCode</th>
            <th>ProdName</th>
            <th>Unit Price</th>
            <th>Content</th>
            <th>QtyBig</th>
            <th>UMBig</th>
            <th>QtySmall</th>
            <th>UMSmall</th>
            <th>Bonus Code</th>
            <th>Gross Price</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>
<script>
    // cek doc code ada atau tidak
    $("#docNumber").on('keyup', function(e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            // jika ada enter, kirim doc number ke controller untuk di cek ke database
            var docNum = $("#docNumber").val();
            $.ajax({
                type: 'POST',
                url: '{{ url('/check-document') }}',
                data: {
                    '_token': '<?php echo csrf_token(); ?>',
                    'doc': docNum,
                },
                success: function(data) {
                    // dari hasil controller nanti di set value sesuai id yang ada (kalau dari controller ada datanya)
                    //  $("#date").val(...);

                    // Kalau dari controller tidak ada data maka field yang harus diisi disablenya hilang
                    $("#date").removeAttr("disabled");
                    $("#custNumber").removeAttr("disabled");
                    $("#prodCode").removeAttr("disabled");
                }
            });
        }
    });

    $(document).ready(function() {
        $("#btnDelete").click(function() {
            var docNum = $("#docNumber").val();
            $.ajax({
                type: 'POST',
                url: '{{ url('/check-document') }}',
                data: {
                    '_token': '<?php echo csrf_token(); ?>',
                    'doc': docNum,
                },
                success: function(data) {
                    // jika berhasil hapus data atau gagal sudah bisa detect alert dari controller pakai session. Cara kembalikan alertnya krn jquery jadinya di controller pakai perintah :
                    // $request->session()->flash('status','Dokumen berhasil dihapus');
                }
            });
        });
    });
</script>
